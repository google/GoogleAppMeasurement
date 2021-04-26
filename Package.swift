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
      name: "GoogleAppMeasurementWithoutAdIdSupport",
      targets: ["GoogleAppMeasurementWithoutAdIdSupportTarget"]
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
      "2.30908.0" ..< "2.30909.0"
    ),
  ],
  targets: [
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
      url: "https://dl.google.com/firebase/ios/swiftpm/7.11.1/GoogleAppMeasurement.zip",
      checksum: "58ef1623b8c1f38a9193add552e17fcd5d15f86bee4d8ac51532ea6ee919c8c2"
    ),

    .target(
      name: "GoogleAppMeasurementWithoutAdIdSupportTarget",
      dependencies: [
        "GoogleAppMeasurementWithoutAdIdSupport",
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
    .binaryTarget(
      name: "GoogleAppMeasurementWithoutAdIdSupport",
      url: "https://dl.google.com/firebase/ios/swiftpm/7.11.1/GoogleAppMeasurementWithoutAdIdSupport.zip",
      checksum: "b783eacf1da6cfeff23f095ce48d1a552358d6cbff559b5911bf67a122a3dce0"
    ),
  ],
  cLanguageStandard: .c99,
  cxxLanguageStandard: CXXLanguageStandard.gnucxx14
)
