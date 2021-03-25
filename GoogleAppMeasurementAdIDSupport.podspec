Pod::Spec.new do |s|
  s.name             = 'GoogleAppMeasurementAdIDSupport'
  s.version          = '7.10.0'
  s.summary          = 'TODO'

  s.description      = <<-DESC
TODO
                       DESC

  s.homepage         = 'https://developers.google.com/'
  s.license          = { :type => 'Apache', :file => 'LICENSE' }
  s.authors          = 'Google, Inc.'
  s.source           = {
    :git => 'https://github.com/google/GoogleAppMeasurement.git',
    :tag => 'CocoaPods-' + s.version.to_s
  }

  s.ios.deployment_target = '9.0'

  s.cocoapods_version = '>= 1.4.0'
  s.prefix_header_file = false

# TODO: Add subspecs

  s.source_files = [
    'GoogleAppMeasurementAdIDSupport/Sources/**/*.[m,h]',
  ]
  s.public_header_files = 'GoogleAppMeasurementAdIDSupport/Sources/Public/GoogleAppMeasurementAdIDSupport/*.h'

  s.pod_target_xcconfig = {
    'GCC_C_LANGUAGE_STANDARD' => 'c99',
    'HEADER_SEARCH_PATHS' => '"${PODS_TARGET_SRCROOT}"'
  }

end
