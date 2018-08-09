#
#  Be sure to run `pod spec lint loadThirdMap.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "loadThirdMap"
s.version      = "0.0.2"
s.summary      = "第三方地图调用."


s.homepage     = "https://www.jianshu.com/u/b0ec154b78be"
# s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
s.license      = "MIT"
s.author             = { "cnw" => "502886513@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/ChenNW/loadThirdMap.git", :tag => "0.0.2" }
s.source_files  = "loadThirdMap", "loadThirdMap/*.{h,m}"
s.frameworks = "UIKit", "Foundation"
s.requires_arc = true

end
