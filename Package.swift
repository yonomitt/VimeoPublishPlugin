// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VimeoPublishPlugin",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "VimeoPublishPlugin",
            targets: ["VimeoPublishPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Publish.git", from: "0.7.0")
    ],
    targets: [
        .target(
            name: "VimeoPublishPlugin",
            dependencies: ["Publish"]),
        .testTarget(
            name: "VimeoPublishPluginTests",
            dependencies: ["VimeoPublishPlugin"])
    ]
)
