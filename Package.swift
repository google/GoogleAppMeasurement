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
    // Deprecated. Use GoogleAdsOnDeviceConversion from
    // https://github.com/googleads/google-ads-on-device-conversion-ios-sdk/ instead.
    .library(
      name: "GoogleAppMeasurementOnDeviceConversion",
      targets: ["GoogleAppMeasurementOnDeviceConversionTarget"]
    ),
  ],
  dependencies: [
    .package(
      name: "GoogleUtilities",
      url: "https://github.com/google/GoogleUtilities.git",
      "8.1.0" ..< "9.0.0"
    ),
    .package(
      name: "nanopb",
      url: "https://github.com/firebase/nanopb.git",
      "2.30910.0" ..< "2.30911.0"
    ),
    .package(
      name: "GoogleAdsOnDeviceConversion",
      url: "https://github.com/googleads/google-ads-on-device-conversion-ios-sdk",
      branch: "nc/release-2.2.2"
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
      url: "https://dl.google.com/firebase/ios/swiftpm/11.15.0/GoogleAppMeasurement.zip",
      checksum: "92b4b30591f2b4c4d9217713268f2d1a18e5e8703cbea0c34d4bc2ea4c2ebf5e"
    ),
    .binaryTarget(
      name: "GoogleAppMeasurementIdentitySupport",
      url: "https://dl.google.com/firebase/ios/swiftpm/11.15.0/GoogleAppMeasurementIdentitySupport.zip",
      checksum: "b03de5d48cde12af3bc7ca1f9c6b45d97db7ef6f90501277aca10c7832b5e21b"
    ),
    .binaryTarget(
      name: "GoogleAppMeasurementOnDeviceConversion",
      url: "https://dl.google.com/firebase/ios/swiftpm/11.15.0/GoogleAppMeasurementOnDeviceConversion.zip",
      checksum: "e8e001c865b3c68c57f8aa1638fceba72c95f9331bc5b7db3cca04615f66cc56"
    ),
  ],
  cLanguageStandard: .c99,
  cxxLanguageStandard: CXXLanguageStandard.gnucxx14
)
