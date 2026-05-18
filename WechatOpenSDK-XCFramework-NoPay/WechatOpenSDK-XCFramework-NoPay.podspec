Pod::Spec.new do |s|
  s.name         = 'WechatOpenSDK-XCFramework-NoPay'
  s.version      = '2.0.5'
  s.summary      = 'WeChat Open SDK without Payment (XCFramework)'
  s.description  = 'WeChat SDK for sharing, login, favorites. Without payment feature.'
  s.homepage     = 'https://mp.weixin.qq.com'
  s.license      = { :type => 'Copyright', :text => 'Copyright 2020 tencent.com. All rights reserved.' }
  s.authors      = { 'tencent' => 'weixin-open@qq.com' }
  s.platform     = :ios, '12.0'

  # 指向你的 GitLab 仓库
  s.source       = { 
    :git => 'https://github.com/Runnershuai-p/wx_sdk_nopay.git', 
    :tag => s.version.to_s 
  }

  s.requires_arc = false
  s.vendored_frameworks = 'WechatOpenSDK.xcframework'

  s.frameworks = [
    'Security', 
    'UIKit', 
    'CoreGraphics', 
    'WebKit'
  ]

  s.libraries = [
    'z', 
    'sqlite3.0', 
    'c++'
  ]

  s.pod_target_xcconfig = {
    'VALID_ARCHS' => 'arm64 x86_64'
  }

  s.user_target_xcconfig = {
    'VALID_ARCHS' => 'arm64 x86_64'
  }
end
