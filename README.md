

## 自建 Podspec 创建流程

### 整体思路

将微信官方提供的**无支付功能版 XCFramework** 托管到自己的 Git 仓库，编写 `.podspec` 文件，通过 CocoaPods 私有源或直接 `:git` 引用来集成。

### 1. 准备 SDK 二进制文件

从微信官方下载不含支付功能的 SDK，得到 `WechatOpenSDK.xcframework`，目录结构：

```
WechatOpenSDK.xcframework/
├── Info.plist
├── PrivacyInfo.xcprivacy          # 隐私清单（iOS 17+ 要求）
├── ios-arm64/                     # 真机
│   └── WechatOpenSDK.framework
└── ios-arm64_x86_64-simulator/    # 模拟器（含 x86_64）
    └── WechatOpenSDK.framework
```

### 2. 创建 Git 仓库

将 xcframework 放入仓库根目录，推送到远程仓库。

### 3. 编写 podspec

`WechatOpenSDK.podspec` 关键配置：

| 字段 | 值 | 说明 |
|------|-----|------|
| `name` | `WechatOpenSDK-xcframework-no` | Pod 名称，区别于官方带支付版 |
| `version` | `2.0.5` | 与 git tag 对应 |
| `platform` | `:ios, '12.0'` | 最低支持 iOS 12 |
| `source` | `:git` + `:tag` | 通过 git tag 拉取对应版本 |
| `vendored_frameworks` | `WechatOpenSDK.xcframework` | 指向预编译二进制 |
| `frameworks` | Security, CoreGraphics, WebKit | 官方要求的系统依赖 |
| `pod_target_xcconfig` | `-ObjC -all_load` | 确保 category 方法被加载 |

### 4. 打 Git Tag

Tag 名称必须与 podspec 中的 `s.version` 一致：

```bash
git tag 2.0.5
git push origin 2.0.5
```

### 5. 使用方式

在项目的 `Podfile` 中引用：

```ruby
# 方式一：直接指定 git 地址
pod 'WechatOpenSDK-xcframework-no', :git => 'https://github.com/Runnershuai-p/wx_sdk_nopay.git', :tag => '2.0.5'

# 方式二：如果加入了私有 Spec Repo
pod 'WechatOpenSDK-xcframework-no', '2.0.5'
```

### 关键注意点

- **Tag 与 version 必须一致** — `s.source` 中用 `s.version.to_s` 动态引用版本号
- **`-ObjC -all_load`** — 微信 SDK 大量使用 ObjC category，缺少这两个标志会导致运行时 crash
- **`requires_arc = false`** — 微信 SDK 自身不使用 ARC
- **PrivacyInfo.xcprivacy** — iOS 17 起 Apple 要求第三方 SDK 提供隐私清单，已包含在 xcframework 中
