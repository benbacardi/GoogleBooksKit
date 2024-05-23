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

struct GoogleBooksVolume: Codable, Identifiable {
    let kind: String
    let id: String
    let etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo?
    let accessInfo: AccessInfo?
    let searchInfo: SearchInfo?
    
    struct VolumeInfo: Codable {
        let title: String
        let authors: [String]
        let publisher: String?
        let publishedDate: String?
        let description: String?
        let industryIdentifiers: [IndustryIdentifier]?
        let readingModes: ReadingModes?
        let pageCount: Int?
        let printType: String?
        let categories: [String]?
        let maturityRating: String?
        let allowAnonLogging: Bool?
        let contentVersion: String?
        let panelizationSummary: PanelizationSummary?
        let imageLinks: ImageLinks?
        let language: String?
        let previewLink: String?
        let infoLink: String?
        let canonicalVolumeLink: String?
    }
    
    struct IndustryIdentifier: Codable {
        let type: String
        let identifier: String
    }
    
    struct ReadingModes: Codable {
        let text: Bool
        let image: Bool
    }
    
    struct PanelizationSummary: Codable {
        let containsEpubBubbles: Bool
        let containsImageBubbles: Bool
    }
    
    struct ImageLinks: Codable {
        let smallThumbnail: String
        let thumbnail: String
    }
    
    struct SaleInfo: Codable {
        let country: String?
        let saleability: String?
        let isEbook: Bool?
        let listPrice: Price?
        let retailPrice: Price?
        let buyLink: String?
        let offers: [Offer]?
    }
    
    struct Price: Codable {
        let amount: Double?
        let currencyCode: String?
    }
    
    struct Offer: Codable {
        let finskyOfferType: Int?
        let listPrice: MicrosPrice?
        let retailPrice: MicrosPrice?
        let giftable: Bool?
    }
    
    struct MicrosPrice: Codable {
        let amountInMicros: Int?
        let currencyCode: String?
    }
    
    struct AccessInfo: Codable {
        let country: String?
        let viewability: String?
        let embeddable: Bool?
        let publicDomain: Bool?
        let textToSpeechPermission: String?
        let epub: Epub?
        let pdf: Pdf?
        let webReaderLink: String?
        let accessViewStatus: String?
        let quoteSharingAllowed: Bool?
    }
    
    struct Epub: Codable {
        let isAvailable: Bool?
    }
    
    struct Pdf: Codable {
        let isAvailable: Bool?
        let acsTokenLink: String?
    }
    
    struct SearchInfo: Codable {
        let textSnippet: String?
    }
}

public struct GoogleBooksVolumeResponse: Codable {
    let kind: String
    let totalItems: Int
    let items: [GoogleBooksVolume]
}
