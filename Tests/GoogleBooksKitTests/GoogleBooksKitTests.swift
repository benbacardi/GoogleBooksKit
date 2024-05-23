import XCTest
@testable import GoogleBooksKit

final class GoogleBooksKitTests: XCTestCase {
    func testSearch() async throws {
        let searchTerm = "day of fallen night"
        let apiKey = ""
        let client = GoogleBooks(apiKey: apiKey)
        if let response = await client.search(searchTerm), let firstResult = response.items.first {
            print("Results: \(response.totalItems)")
            print("First result: \(firstResult.volumeInfo.title) by \(firstResult.volumeInfo.authors.first ?? "Nobody")")
            print("Cover: \(firstResult.volumeInfo.imageLinks?.smallThumbnail ?? "No cover")")
        } else {
            print("No results.")
        }
    }
}
