#
# Be sure to run `pod lib lint AKBasis.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AKBasis'
  s.version          = '0.3.0'
  s.summary          = 'Base things for projects: Routing, Assembly and other'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/konshin/AKBasis'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aleksey Konshin' => 'alexey.konshin@exness.com' }
  s.source           = { :git => 'https://github.com/konshin/AKBasis.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'AKBasis/Classes/**/*'
  s.swift_version = '5.0'

  s.dependency 'SnapKit', '~> 5.0'
end
