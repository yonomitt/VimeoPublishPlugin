// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VimeoPublishPlugin",
    products: [
        .library(
            name: "VimeoPublishPlugin",
            targets: ["VimeoPublishPlugin"]),
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0"),
    ],
    targets: [
        .target(
            name: "VimeoPublishPlugin",
            dependencies: ["Publish"]),
        .testTarget(
            name: "VimeoPublishPluginTests",
            dependencies: ["VimeoPublishPlugin"]),
    ]
)
