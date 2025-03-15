// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustardKit",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CustardKit",
            targets: ["CustardKit"]
        ),
        .executable(
            name: "samples",
            targets: ["samples"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CustardKit",
            dependencies: [],
            path: "swift/sources"
        ),
        .testTarget(
            name: "CustardKitTests",
            dependencies: ["CustardKit"],
            path: "swift/tests/CustardKitTests"
        ),
        .executableTarget(
            name: "samples",
            dependencies: [
                "CustardKit",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "swift/examples"
        )
    ]
)
