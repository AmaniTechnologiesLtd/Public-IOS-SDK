#
#  Be sure to run `pod spec lint Amani.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "Amani"
  s.version      = "1.2.31"
  s.summary      = "Amani-SDK"
  s.description  = "The Amani Software Development kit (SDK) provides you complete steps to perform eKYC."
  s.homepage     = "https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK"
  s.license      = "Copyright"
  s.author       = "Amani"
  s.platform     = :ios, "10.0"
  s.source       = { :git => 'https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK.git', :tag => "#{s.version}"}
 #s.dependency 'Alamofire', '>=5.2'
  s.dependency 'SwiftLint'
  s.dependency 'IQKeyboardManagerSwift'
  s.dependency "lottie-ios"
  s.dependency 'OpenSSL-Universal'
  s.xcconfig          = { 'OTHER_LDFLAGS' => '-weak_framework CryptoKit -weak_framework CoreNFC -weak_framework CryptoTokenKit'}
  s.ios.deployment_target = '10.0'
  s.vendored_frameworks = 'Amani.xcframework'
  

end
