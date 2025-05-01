// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import PackageDescription

let package = Package(
  name: "GoogleAppMeasurement",
  platforms: [.iOS(.v12), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v7)],
  products: [
    .library(
      name: "GoogleAppMeasurement",
      targets: ["GoogleAppMeasurementTarget"]
    ),
    .library(
      name: "GoogleAppMeasurementCore",
      targets: ["GoogleAppMeasurementCoreTarget"]
    ),
    .library(
      name: "GoogleAppMeasurementIdentitySupport",
      targets: ["GoogleAppMeasurementIdentitySupportTarget"]
    ),
    // Deprecated. Use GoogleAppMeasurementCore instead.
    .library(
      name: "GoogleAppMeasurementWithoutAdIdSupport",
      targets: ["GoogleAppMeasurementWithoutAdIdSupportTarget"]
    ),
    // Deprecated. Use GoogleAdsOnDeviceConversion instead.
    .library(
      name: "GoogleAppMeasurementOnDeviceConversion",
      targets: ["GoogleAppMeasurementOnDeviceConversionTarget"]
    ),
  ],
  dependencies: [
    .package(
      name: "GoogleUtilities",
      url: "https://github.com/google/GoogleUtilities.git",
      "8.0.0" ..< "9.0.0"
    ),
    .package(
      name: "nanopb",
      url: "https://github.com/firebase/nanopb.git",
      "2.30910.0" ..< "2.30911.0"
    ),
    .package(
      name: "GoogleAdsOnDeviceConversion",
      url: "https://github.com/googleads/google-ads-on-device-conversion-ios-sdk",
      "1.3.0" ..< "3.0.0"
    ),
  ],
  targets: [
    .target(
      name: "GoogleAppMeasurementTarget",
      dependencies: [
        .target(
          name: "GoogleAppMeasurementIdentitySupport",
          condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])
        ),
        .target(
          name: "GoogleAppMeasurement",
          condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])
        ),
        
        .product(name: "GULAppDelegateSwizzler", package: "GoogleUtilities"),
        .product(name: "GULMethodSwizzler", package: "GoogleUtilities"),
        .product(name: "GULNSData", package: "GoogleUtilities"),
        .product(name: "GULNetwork", package: "GoogleUtilities"),
        .product(name: "nanopb", package: "nanopb"),
        .product(name: "GoogleAdsOnDeviceConversion", package: "GoogleAdsOnDeviceConversion"),
      ],
      path: "GoogleAppMeasurementWrapper",
      linkerSettings: [
        .linkedLibrary("sqlite3"),
        .linkedLibrary("c++"),
        .linkedLibrary("z"),
        .linkedFramework("StoreKit"),
      ]
    ),
    .target(
      name: "GoogleAppMeasurementCoreTarget",
      dependencies: [
        .target(
          name: "GoogleAppMeasurement",
          condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])
        ),
        .product(name: "GULAppDelegateSwizzler", package: "GoogleUtilities"),
        .product(name: "GULMethodSwizzler", package: "GoogleUtilities"),
        .product(name: "GULNSData", package: "GoogleUtilities"),
        .product(name: "GULNetwork", package: "GoogleUtilities"),
        .product(name: "nanopb", package: "nanopb"),
      ],
      path: "GoogleAppMeasurementCoreWrapper",
      linkerSettings: [
        .linkedLibrary("sqlite3"),
        .linkedLibrary("c++"),
        .linkedLibrary("z"),
        .linkedFramework("StoreKit"),
      ]
    ),
    .target(
      name: "GoogleAppMeasurementIdentitySupportTarget",
      dependencies: [
        .target(
          name: "GoogleAppMeasurementIdentitySupport",
          condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])
        ),
        .target(
          name: "GoogleAppMeasurement",
          condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])
        ),
        .product(name: "GULAppDelegateSwizzler", package: "GoogleUtilities"),
        .product(name: "GULMethodSwizzler", package: "GoogleUtilities"),
        .product(name: "GULNSData", package: "GoogleUtilities"),
        .product(name: "GULNetwork", package: "GoogleUtilities"),
        .product(name: "nanopb", package: "nanopb"),
      ],
      path: "GoogleAppMeasurementIdentitySupportWrapper",
      linkerSettings: [
        .linkedLibrary("sqlite3"),
        .linkedLibrary("c++"),
        .linkedLibrary("z"),
        .linkedFramework("StoreKit"),
      ]
    ),
    .target(
      name: "GoogleAppMeasurementWithoutAdIdSupportTarget",
      dependencies: [
        .target(
          name: "GoogleAppMeasurement",
          condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])
        ),
        .product(name: "GULAppDelegateSwizzler", package: "GoogleUtilities"),
        .product(name: "GULMethodSwizzler", package: "GoogleUtilities"),
        .product(name: "GULNSData", package: "GoogleUtilities"),
        .product(name: "GULNetwork", package: "GoogleUtilities"),
        .product(name: "nanopb", package: "nanopb"),
      ],
      path: "GoogleAppMeasurementWithoutAdIdSupportWrapper",
      linkerSettings: [
        .linkedLibrary("sqlite3"),
        .linkedLibrary("c++"),
        .linkedLibrary("z"),
        .linkedFramework("StoreKit"),
      ]
    ),
    .target(
      name: "GoogleAppMeasurementOnDeviceConversionTarget",
      dependencies: [
        .target(
          name: "GoogleAppMeasurementOnDeviceConversion",
          condition: .when(platforms: [.iOS])
        ),
      ],
      path: "GoogleAppMeasurementOnDeviceConversionWrapper",
      linkerSettings: [
        .linkedLibrary("c++"),
      ]
    ),
    .binaryTarget(
      name: "GoogleAppMeasurement",
      url: "https://dl.google.com/firebase/ios/swiftpm/11.13.0/GoogleAppMeasurement.zip",
      checksum: "92be005e6021dec6cb862c6be559f02a172c12e303ac4a1fba8aafef40b5768c"
    ),
    .binaryTarget(
      name: "GoogleAppMeasurementIdentitySupport",
      url: "https://dl.google.com/firebase/ios/swiftpm/11.13.0/GoogleAppMeasurementIdentitySupport.zip",
      checksum: "e87a3ab081ff19658861c8cda4a633b1dd316f3acd608f54b35c986cf2b1cadf"
    ),
    .binaryTarget(
      name: "GoogleAppMeasurementOnDeviceConversion",
      url: "https://dl.google.com/firebase/ios/swiftpm/11.13.0/GoogleAppMeasurementOnDeviceConversion.zip",
      checksum: "cdcf18e21f2a36e1d7dfcbe6b7b698e35c0acbf6b988e92b273580ccc35c7434"
    ),
  ],
  cLanguageStandard: .c99,
  cxxLanguageStandard: CXXLanguageStandard.gnucxx14
)
