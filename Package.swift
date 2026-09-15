// swift-tools-version:6.0
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
  platforms: [.iOS(.v15), .macOS(.v10_15), .tvOS(.v15), .watchOS(.v7)],
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
  ],
  dependencies: [
    .package(url: "https://github.com/google/GoogleUtilities.git", "8.1.0" ..< "9.0.0"),
    .package(url: "https://github.com/firebase/nanopb.git", "2.30910.0" ..< "2.30911.0"),
    .package(
      url: "https://github.com/googleads/google-ads-on-device-conversion-ios-sdk",
      "3.7.0" ..< "3.8.0"
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
        .product(name: "GULLogger", package: "GoogleUtilities"),
        .product(name: "GULEnvironment", package: "GoogleUtilities"),
        .product(name: "nanopb", package: "nanopb"),
        .product(
          name: "GoogleAdsOnDeviceConversion", package: "google-ads-on-device-conversion-ios-sdk"
        ),
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
        .product(name: "GULLogger", package: "GoogleUtilities"),
        .product(name: "GULEnvironment", package: "GoogleUtilities"),
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
        .product(name: "GULLogger", package: "GoogleUtilities"),
        .product(name: "GULEnvironment", package: "GoogleUtilities"),
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
    .binaryTarget(
      name: "GoogleAppMeasurement",
      url: "https://dl.google.com/firebase/ios/swiftpm/12.19.2/GoogleAppMeasurement.zip",
      checksum: "b7d529c22a11411fb112772db2b80d134fc2b2e5d67899ab1f67a6b36ed23603"
    ),
    .binaryTarget(
      name: "GoogleAppMeasurementIdentitySupport",
      url: "https://dl.google.com/firebase/ios/swiftpm/12.19.2/GoogleAppMeasurementIdentitySupport.zip",
      checksum: "600d586bf3fb35b69822487f3748691b241b6eba70e75cc344ed8dcd55da2626"
    ),
  ],
  cLanguageStandard: .c99,
  cxxLanguageStandard: CXXLanguageStandard.gnucxx14
)
