#
#  Be sure to run `pod spec lint ProjectLibrary.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ProjectLibrary"
  s.version      = "1.0.5"
  s.summary      = "ProjectLibrary  developing tools"

  s.description  = <<-DESC
                      ProjectLibrary  developing tools for author use
                   DESC

  s.homepage     = "https://github.com/1273011249/ProjectLibrary"


  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "xuyong" => "1273011249@qq.com" }

  s.platform     = :ios, '7.0'

  s.source       = { :git => "https://github.com/1273011249/ProjectLibrary.git", :tag => "1.0.5" }

  s.source_files  = "ProjectLibrary/Classes/*.{h,m}","ProjectLibrary/Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.public_header_files = "ProjectLibrary/Classes/*.h"

  s.requires_arc = true

end



