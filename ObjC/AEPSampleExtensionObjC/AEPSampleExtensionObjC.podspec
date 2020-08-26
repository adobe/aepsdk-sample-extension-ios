Pod::Spec.new do |s|
  s.name             = "AEPSampleExtensionObjC"
  s.version          = "0.0.1"
  s.summary          = "AEPSampleExtensionObjC"
  s.description      = <<-DESC
AEPSampleExtensionObjC
                        DESC
  s.homepage         = "https://github.com/adobe/aepsdk-sample-extension-ios"
  s.license          = 'Apache V2'
  s.author       = "Adobe Experience Platform SDK Team"
  s.source           = { :git => "https://github.com/adobe/aepsdk-sample-extension-ios/objC", :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files          = 'AEPSampleExtensionObjC/**/*.swift'

  s.swift_version = '5.0'
  s.pod_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }

  s.dependency 'AEPCore'

end