

Pod::Spec.new do |s|
  s.name             = 'Configurate'
  s.version          = '2.0.0'
  s.summary          = 'An abstract, cross-platform configuration library for Swift applications.'

  s.description      = <<-DESC
Configurate provides a common interface for configuration type objects (e.g. UserDefaults, [String: Any], etc).
It also provides a builder pattern for composing configurations into a single Config object.
                       DESC

  s.homepage         = 'https://github.com/patgoley/Configurate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Patrick Goley' => 'patrick.goley@gmail.com' }
  s.source           = { :git => 'https://github.com/patgoley/Configurate.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/bitsbetweenbits'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/Configurate/**/*'
end
