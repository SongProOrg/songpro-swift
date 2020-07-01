import XCTest
@testable import SongPro

final class SongProTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SongPro().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
