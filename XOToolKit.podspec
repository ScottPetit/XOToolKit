Pod::Spec.new do |s|
  s.name         = "XOToolKit"
  s.version      = "0.13"
  s.summary      = "A small library of convenience methods."
  s.homepage     = "https://github.com/ScottPetit/XOToolKit"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Scott Petit" => "petit.scott@gmail.com" }
  s.source       = { :git => "https://github.com/ScottPetit/XOToolKit.git", :tag => "v0.13" }
  s.platform     = :ios, '5.0'
  s.source_files = 'Classes', '*.{h,m}','**/*.{h,m}'
  s.requires_arc = true
end
