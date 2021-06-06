// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TitleBar",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "TitleBar", targets: ["TitleBar"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "TitleBar", dependencies: [], path: "Sources", exclude: ["Info.plist"])
    ]
)
