import ArgumentParser


@main
struct S3Uploader: AsyncParsableCommand {
    @Argument(help: "<input path> <s3 path>")
    var paths: [String]

    func run() async throws {
        guard paths.count == 2 else {
            throw ValidationError("Must have exactly 2 arguments: <input path> <S3 path>")
        }
        let inputPath = paths[0]
        let s3Path = paths[1]
        print(inputPath, "->", s3Path)
    }
}
