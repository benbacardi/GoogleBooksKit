// The Swift Programming Language
// https://docs.swift.org/swift-book

import APIClient

public class GoogleBooks {
    
    private let apiKey: String
    private let client = APIClient()
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
}

extension GoogleBooks {
    
    enum Constants {
        static let baseGroup = Group(host: "www.googleapis.com", path: "/books/v1/")
    }
    
    enum Requests {
        static func searchVolumesRequest() -> AdvancedRequest<Nothing, [String: String], SearchQuery, VolumeResponse, ErrorResponse> {
            Constants.baseGroup.request(path: "volumes")
        }
    }
    
    public typealias APIError = APIClientError<ErrorResponse>
 
    public func search(_ searchTerm: String, startIndex: Int = 0, maxResults: Int = 20) async throws -> VolumeResponse {
        return try await client.make(request: Requests.searchVolumesRequest(), queries: SearchQuery(q: searchTerm, startIndex: startIndex, maxResults: maxResults, key: self.apiKey)).data
    }
    
}
