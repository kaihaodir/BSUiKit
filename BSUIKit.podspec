#BSUIKit.podspec
Pod::Spec.new do |s|
  s.name         = "BSUIKit"
  s.version      = "1.0.0"
  s.summary      = "a base ui tools collection."

  s.homepage     = "https://github.com/kaihaodir/BSUiKit"
  s.license      = 'MIT'
  s.author       = { "Kai.Li" => "kaihaodir@gmail.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/kaihaodir/BSUiKit.git", :tag => s.version}
  s.source_files  = '*.*'
  s.requires_arc = true
end
