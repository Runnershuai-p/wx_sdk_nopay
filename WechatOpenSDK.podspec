Pod::Spec.new do |s|
  s.name         = 'WechatOpenSDK-xcframework-no'
  s.version      = '2.0.5'
  s.summary      = 'WeChat Open SDK without Payment (XCFramework)'
  s.description  = 'WeChat SDK for sharing, login, favorites. Without payment feature.'
  s.homepage     = 'https://developers.weixin.qq.com/doc/oplatform/Mobile_App/Access_Guide/iOS.html'
  s.license      = { :type => 'Copyright', :text => 'Copyright 2020 Tencent. All rights reserved.' }
  s.authors      = { 'Tencent' => 'name' }

  s.platform     = :ios, '12.0'

  s.source       = {
    :git => 'https://github.com/Runnershuai-p/wx_sdk_nopay.git',
    :tag => s.version.to_s
  }

  s.requires_arc = false
  s.vendored_frameworks = 'WechatOpenSDK.xcframework'

  # 官方文档要求的系统 Frameworks
  s.frameworks = [
    "Security",
    "UIKit",
    "CoreGraphics",
    "WebKit"
  ]

  # 官方文档要求的系统 Libraries
  s.libraries = [
    'z',
    'sqlite3',
    'c++'
  ]

  # 链接标志
  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS'       => '-ObjC -all_load'
  }


end