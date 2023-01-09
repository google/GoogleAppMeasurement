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
  platforms: [.iOS(.v10), .macOS(.v10_12), .tvOS(.v12)],
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
      "7.2.1" ..< "8.0.0"
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
        "GoogleAppMeasurementIdentitySupport",
        "GoogleAppMeasurement",
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
        "GoogleAppMeasurement",
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
        "GoogleAppMeasurementOnDeviceConversion",
      ],
      path: "GoogleAppMeasurementOnDeviceConversionWrapper",
      linkerSettings: [
        .linkedLibrary("c++"),
      ]
    ),
    .binaryTarget(
      name: "GoogleAppMeasurement",
      url: "https://dl.google.com/firebase/ios/swiftpm/10.4.0/GoogleAppMeasurement.zip",
      checksum: "962c7eebd5d00bc7a02ede929f11040cde9af03ee147b0582b479da8eba79ecf"
    ),
    .binaryTarget(
      name: "GoogleAppMeasurementIdentitySupport",
      url: "https://dl.google.com/firebase/ios/swiftpm/10.4.0/GoogleAppMeasurementIdentitySupport.zip",
      checksum: "496fc898ad3dbe95cd832fb9a417fbd87810be44a4fc0b17c8b0ce176407fd6d"
    ),
    .binaryTarget(
      name: "GoogleAppMeasurementOnDeviceConversion",
      url: "https://dl.google.com/firebase/ios/swiftpm/10.1.0/GoogleAppMeasurementOnDeviceConversion.zip",
      checksum: "bae7b2552240c8fe499481c67378395d29f1d2c73ec700bff73aa77eefc0753b"
    ),
  ],
  cLanguageStandard: .c99,
  cxxLanguageStandard: CXXLanguageStandard.gnucxx14
)
