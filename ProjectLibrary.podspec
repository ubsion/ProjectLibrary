

Pod::Spec.new do |s|

 

  s.name         = "ProjectLibrary"
  s.version      = "1.0.0"
  s.summary      = "ProjectLibrary  developing tools"

  s.description  = <<-DESC
                      ProjectLibrary  developing tools
                   DESC

  s.homepage     = "https://github.com/1273011249/ProjectLibrary"


  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "xuyong" => "1273011249@qq.com" }

  s.platform     = :ios, '7.0'


  s.source       = { :git => "https://github.com/1273011249/ProjectLibrary.git", :tag => "1.0.0" }


  s.source_files  = "Classes", "ProjectLibrary/Classes/"
  s.exclude_files = "Classes/Classes/Exclude"

  s.public_header_files = "ProjectLibrary/Classes/*.h"

  s.requires_arc = true

end
