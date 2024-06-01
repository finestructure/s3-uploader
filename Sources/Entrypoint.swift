import Foundation

import ArgumentParser


@main
struct S3Uploader: AsyncParsableCommand {
    @Argument(help: "<input path> <s3 path>")
    var paths: [String]

    func run() async throws {
        guard paths.count == 2 else {
            throw ValidationError("Must have exactly 2 arguments: <input path> <S3 path>")
        }

        try await fetch()
    }

    func fetch() async throws {
        let url = "https://raw.githubusercontent.com/finestructure/s3-uploader/main/Package.swift"
        print("Fetching \(url)...")

        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
        print("Received:")
        print(String(decoding: data, as: UTF8.self))
    }
}
