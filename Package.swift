// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "visp-ios",
    platforms: [
        .macOS(.v10_14), .iOS(.v17)
    ],
    products: [
        .library(name: "visp3", targets: ["visp3"])
    ],
    targets: [
        .binaryTarget(name: "visp3",
                      url: "https://github.com/huyaoyu/visp-ios/releases/download/v3.6.0/visp3.xcframework.zip",
                      checksum: "b1751fa3db956acd1a50b7a90765cf233ee2c73777e56fe211b54d7e335bfe15")
    ]
)
