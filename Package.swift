// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "adopt",
  platforms: [
    .macOS(.v10_15)
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Auth"
    ),
    .target(
      name: "Run",
      dependencies: [
        .target(name: "Auth")
      ]
    ),
    .testTarget(
      name: "AuthTests",
      dependencies: [
        .target(name: "Auth")
      ]
    )
  ]
)
