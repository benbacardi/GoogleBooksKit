// The Swift Programming Language
// https://docs.swift.org/swift-book

import APIClient

enum GoogleBooksConstants {
    static let baseGroup = Group(host: "www.googleapis.com", path: "/books/v1/")
}

enum GoogleBooksRequests {
    static func searchVolumesRequest() -> AdvancedRequest<Nothing, [String: String], GoogleBooksSearchQuery, GoogleBooksVolumeResponse, GoogleBooksErrorResponse> {
        GoogleBooksConstants.baseGroup.request(path: "volumes")
    }
}

typealias GoogleBooksAPIError = APIClientError<GoogleBooksErrorResponse>

public class GoogleBooks {
    
    private let apiKey: String
    private let client = APIClient()
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func search(_ searchTerm: String) async -> GoogleBooksVolumeResponse? {
        do {
            return try await client.make(request: GoogleBooksRequests.searchVolumesRequest(), queries: GoogleBooksSearchQuery(q: searchTerm, key: self.apiKey)).data
        } catch let error as GoogleBooksAPIError {
            switch error {
            case .responseError(let olError, meta: let meta, underlyingError: let underlying):
                print("Term: \(searchTerm) OL: \(olError) Meta: \(meta.debugDescription) Underlying: \(underlying)")
            case .unexpectedResponseError(data: let data, meta: let meta, underlyingError: let underlying):
                print("Term: \(searchTerm) Data: \(String(data: data, encoding: .utf8).debugDescription) Meta: \(meta.debugDescription) Underlying: \(underlying)")
            case .otherError(let error):
                print("Term: \(searchTerm) Error in API response: \(error.localizedDescription)")
            }
        } catch {
            print("Term: \(searchTerm) Error while searching: \(error.localizedDescription)")
        }
        return nil
    }
    
}
