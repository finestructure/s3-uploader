// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "s3-uploader",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.4.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.1")
    ],
    targets: [
        .executableTarget(name: "s3-uploader", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            .product(name: "Alamofire", package: "alamofire")
        ]),
    ]
)
