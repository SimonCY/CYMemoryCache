#
# Be sure to run `pod lib lint CYMemoryCache.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CYMemoryCache'
  s.version          = '0.1.0'
  s.summary          = 'A easy memory cache manager with LRU'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/SimonCY/CYMemoryCache'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SimonCY' => '397604080@qq.com' }
  s.source           = { :git => 'https://github.com/SimonCY/CYMemoryCache.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'CYMemoryCache/Classes/**/*.{h,m}'
  
  # s.resource_bundles = {
  #   'CYMemoryCache' => ['CYMemoryCache/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
