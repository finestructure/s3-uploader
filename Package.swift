// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "s3-uploader",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.4.0")
    ],
    targets: [
        .executableTarget(name: "s3-uploader", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser")
        ]),
    ]
)
