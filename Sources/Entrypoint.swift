import ArgumentParser
import SotoS3FileTransfer


@main
struct S3Uploader: AsyncParsableCommand {
    @Argument(help: "<input path> <s3 path>")
    var paths: [String]

    func run() async throws {
        guard paths.count == 2 else {
            throw ValidationError("Must have exactly 2 arguments: <input path> <S3 path>")
        }
        try await Self.upload(from: paths[0], to: paths[1])
    }

    static func upload(from inputPath: String, to s3Path: String) async throws {
        let client = AWSClient(httpClientProvider: .createNew)
        defer { try? client.syncShutdown() }

        let s3 = S3(client: client, region: .useast2)
        let s3FileTransfer = S3FileTransferManager(s3: s3, threadPoolProvider: .singleton)

        guard let s3File = S3File(url: s3Path) else {
            throw Error(message: "Filed to construct S3File for url: \(s3Path)")
        }

        print("Uploading \(inputPath) -> \(s3Path) ...")
        do {
            try await s3FileTransfer.copy(from: inputPath, to: s3File).get()
            print("Done.")
        } catch {
            print("Error while uploading file: \(error)")
        }
    }

    struct Error: Swift.Error {
        let message: String

        var localizedDescription: String { message }
    }
}
