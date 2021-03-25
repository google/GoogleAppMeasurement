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
  platforms: [.iOS(.v10)],
  products: [
    .library(
      name: "GoogleAppMeasurement",
      targets: ["GoogleAppMeasurementTarget"]
    ),
    .library(
      name: "GoogleAppMeasurementAdIDSupport",
      targets: ["GoogleAppMeasurementAdIDSupport"]
    ),
//    .library(
//      name: "GoogleAppMeasurementNoAdIDSupport",
//      targets: ["GoogleAppMeasurementNoAdIDSupport"]
//    ),
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
      "2.30907.0" ..< "2.30908.0"
    ),
  ],
  targets: [
    // MARK: - AppMeasurement
    .target(
      name: "GoogleAppMeasurementTarget",
      dependencies: [
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
    .binaryTarget(
      name: "GoogleAppMeasurement",
      url: "https://dl.google.com/firebase/ios/swiftpm/7.9.0/GoogleAppMeasurement.zip",
      checksum: "3cce0986d8da23a7eca1fbdff6170866dbe2be528da4a1605e598de342574f49"
    ),

    // MARK: - Ad ID Support
    .target(
      name: "GoogleAppMeasurementAdIDSupport",
      path: "GoogleAppMeasurementAdIDSupport/Sources",
      publicHeadersPath: "Public",
      cSettings: [
        .headerSearchPath("../../Protocols/"),
        .headerSearchPath("../../"),
      ]
    ),
    .testTarget(
      name: "AdIDSupportTests",
      dependencies: ["GoogleAppMeasurementAdIDSupport"],
      path: "GoogleAppMeasurementAdIDSupport/Tests",
      cSettings: [
        .headerSearchPath("../../Protocols"),
        .headerSearchPath("../../"),
      ]
    ),

    // MARK: - Without Ad ID Support
    .target(
      name: "GoogleAppMeasurementWithoutAdIDSupport",
      path: "GoogleAppMeasurementWithoutAdIDSupport/Sources",
      publicHeadersPath: "Public",
      cSettings: [
        .headerSearchPath("../../Protocols"),
        .headerSearchPath("../../"),
      ]
    ),
    .testTarget(
      name: "WithoutAdIDSupportTests",
      dependencies: ["GoogleAppMeasurementWithoutAdIDSupport"],
      path: "GoogleAppMeasurementWithoutAdIDSupport/Tests",
      cSettings: [
        .headerSearchPath("../../Protocols"),
        .headerSearchPath("../../"),
      ]
    ),

//    // MARK: - Ad ID Support
//    .target(
//      name: "GoogleAppMeasurementNoAdIDSupport",
//      dependencies: ["GoogleAppMeasurementAdIDSupport"],
//      path: "GoogleAppMeasurementNoAdIDSupport/Sources",
//      publicHeadersPath: "Public",
//      cSettings: [
//        .define("BUILDFAIL", to: "1")
//      ]
//    ),
  ],
  cLanguageStandard: .c99,
  cxxLanguageStandard: CXXLanguageStandard.gnucxx14
)
