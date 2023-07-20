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
  platforms: [.iOS(.v10), .macOS(.v10_12), .tvOS(.v12), .watchOS(.v6)],
  products: [
    .library(
      name: "GoogleAppMeasurement",
      targets: ["GoogleAppMeasurementTarget"]
    ),
    .library(
      name: "GoogleAppMeasurementWithoutAdIdSupport",
      targets: ["GoogleAppMeasurementWithoutAdIdSupportTarget"]
    ),
    .library(
      name: "GoogleAppMeasurementOnDeviceConversion",
      targets: ["GoogleAppMeasurementOnDeviceConversionTarget"]
    ),
  ],
  dependencies: [
    .package(
      name: "GoogleUtilities",
      url: "https://github.com/google/GoogleUtilities.git",
      "7.11.0" ..< "8.0.0"
    ),
    .package(
      name: "nanopb",
      url: "https://github.com/firebase/nanopb.git",
      "2.30908.0" ..< "2.30910.0"
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
      url: "https://dl.google.com/firebase/ios/swiftpm/10.12.0/GoogleAppMeasurement.zip",
      checksum: "00fbacf0ad93e576e4dbb464784df4c507cf1e392699a0d1969a2bf9d6996930"
    ),
    .binaryTarget(
      name: "GoogleAppMeasurementIdentitySupport",
      url: "https://dl.google.com/firebase/ios/swiftpm/10.12.0/GoogleAppMeasurementIdentitySupport.zip",
      checksum: "f942eaa3cbe8d41d68caa5cfe2cfbac3a0d76c0d685b4c8031b0a62e419586d2"
    ),
    .binaryTarget(
      name: "GoogleAppMeasurementOnDeviceConversion",
      url: "https://dl.google.com/firebase/ios/swiftpm/10.10.0/GoogleAppMeasurementOnDeviceConversion.zip",
      checksum: "7b998fb81ca0086f20c98cd52d1856e68803e28075296f15dd26d031cdc7246b"
    ),
  ],
  cLanguageStandard: .c99,
  cxxLanguageStandard: CXXLanguageStandard.gnucxx14
)
