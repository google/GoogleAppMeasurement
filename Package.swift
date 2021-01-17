// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Copyright 2020 Google LLC
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

let firebaseVersion = "7.3.1"

let package = Package(
  name: "GoogleAppMeasurement",
  platforms: [.iOS(.v10)],
  products: [
    .library(
      name: "GoogleAppMeasurement",
      targets: ["GoogleAppMeasurementTarget"]
    ),
  ],
  dependencies: [
    .package(
      name: "GoogleUtilities",
      url: "https://github.com/google/GoogleUtilities.git",
      "7.2.0" ..< "8.0.0"
    ),
  ],
  targets: [
    .target(
      name: "GoogleAppMeasurementTarget",
      dependencies: [
        .target(name: "GoogleAppMeasurementWrapper
      ],
      path: "SwiftPM-PlatformExclude/GoogleAppMeasurementWrap"
    ),

    .target(
      name: "GoogleAppMeasurement",
      dependencies: [
        .target(name: "GoogleAppMeasurementBinary", condition: .when(platforms: [.iOS])),
        "FirebaseCore",
        "FirebaseInstallations",
        "GoogleUtilities_AppDelegateSwizzler",
        "GoogleUtilities_MethodSwizzler",
        "GoogleUtilities_NSData",
        "GoogleUtilities_Network",
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
      name: "GoogleAppMeasurementBinary",
      url: "https://dl.google.com/firebase/ios/swiftpm/7.4.0/GoogleAppMeasurement.zip",
      checksum: "5c4e13589e8b5c357309dd8e5f57d81ab3e3ee5a731b034c4703e700d60d667a"
    ),

  ],
  cLanguageStandard: .c99,
  cxxLanguageStandard: CXXLanguageStandard.gnucxx14
)
