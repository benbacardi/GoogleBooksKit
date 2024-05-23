//
//  Model.swift
//
//
//  Created by Ben Cardy on 23/05/2024.
//

import Foundation
import APIClient

// MARK: Errors

struct GoogleBooksError: Codable {
    let message: String
    let domain: String
    let reason: String
}

struct GoogleBooksErrorWrapper: Codable {
    let code: Int
    let message: String
    let errors: [GoogleBooksError]
}

struct GoogleBooksErrorResponse: Codable, LocalizedError {
    let error: GoogleBooksErrorWrapper
    var errorDescription: String { error.message }
}

// MARK: Queries

struct GoogleBooksSearchQuery: StringKeyValueConvertible {
    let q: String
    let key: String
    
    public func keyValues() -> [KeyValuePair<String>] {
        return [
            ("q", q),
            ("key", key),
        ]
    }
}

// MARK: Responses

public struct GoogleBooksVolume: Codable, Identifiable {
    public let kind: String
    public let id: String
    public let etag: String
    public let selfLink: String
    public let volumeInfo: VolumeInfo
    public let saleInfo: SaleInfo?
    public let accessInfo: AccessInfo?
    public let searchInfo: SearchInfo?
    
    public struct VolumeInfo: Codable {
        public let title: String
        public let authors: [String]
        public let publisher: String?
        public let publishedDate: String?
        public let description: String?
        public let industryIdentifiers: [IndustryIdentifier]?
        public let readingModes: ReadingModes?
        public let pageCount: Int?
        public let printType: String?
        public let categories: [String]?
        public let maturityRating: String?
        public let allowAnonLogging: Bool?
        public let contentVersion: String?
        public let panelizationSummary: PanelizationSummary?
        public let imageLinks: ImageLinks?
        public let language: String?
        public let previewLink: String?
        public let infoLink: String?
        public let canonicalVolumeLink: String?
    }
    
    public struct IndustryIdentifier: Codable {
        public let type: String
        public let identifier: String
    }
    
    public struct ReadingModes: Codable {
        public let text: Bool
        public let image: Bool
    }
    
    public struct PanelizationSummary: Codable {
        public let containsEpubBubbles: Bool
        public let containsImageBubbles: Bool
    }
    
    public struct ImageLinks: Codable {
        public let smallThumbnail: String
        public let thumbnail: String
    }
    
    public struct SaleInfo: Codable {
        public let country: String?
        public let saleability: String?
        public let isEbook: Bool?
        public let listPrice: Price?
        public let retailPrice: Price?
        public let buyLink: String?
        public let offers: [Offer]?
    }
    
    public struct Price: Codable {
        public let amount: Double?
        public let currencyCode: String?
    }
    
    public struct Offer: Codable {
        public let finskyOfferType: Int?
        public let listPrice: MicrosPrice?
        public let retailPrice: MicrosPrice?
        public let giftable: Bool?
    }
    
    public struct MicrosPrice: Codable {
        public let amountInMicros: Int?
        public let currencyCode: String?
    }
    
    public struct AccessInfo: Codable {
        public let country: String?
        public let viewability: String?
        public let embeddable: Bool?
        public let publicDomain: Bool?
        public let textToSpeechPermission: String?
        public let epub: Epub?
        public let pdf: Pdf?
        public let webReaderLink: String?
        public let accessViewStatus: String?
        public let quoteSharingAllowed: Bool?
    }
    
    public struct Epub: Codable {
        public let isAvailable: Bool?
    }
    
    public struct Pdf: Codable {
        public let isAvailable: Bool?
        public let acsTokenLink: String?
    }
    
    public struct SearchInfo: Codable {
        public let textSnippet: String?
    }
}

public struct GoogleBooksVolumeResponse: Codable {
    public let kind: String
    public let totalItems: Int
    public let items: [GoogleBooksVolume]
}
