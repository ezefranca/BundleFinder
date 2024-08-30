import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let lookupResponse = try? JSONDecoder().decode(LookupResponse.self, from: jsonData)

// MARK: - LookupResponse
struct LookupResponse: Codable {
    let resultCount: Int?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable, Hashable {
    
    static func == (lhs: Result, rhs: Result) -> Bool {
        lhs.bundleID == rhs.bundleID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
    
    
    let screenshotUrls, ipadScreenshotUrls: [String]?
    let appletvScreenshotUrls: [String?]?
    let artworkUrl60, artworkUrl512, artworkUrl100: String?
    let artistViewURL: String?
    let isGameCenterEnabled: Bool?
    let features: [String]?
    let advisories: [String?]?
    let supportedDevices: [String]?
    let kind, minimumOSVersion, primaryGenreName: String?
    let primaryGenreID: Int?
    let isVppDeviceBasedLicensingEnabled: Bool?
    let averageUserRatingForCurrentVersion, averageUserRating: Double?
    let trackCensoredName: String?
    let languageCodesISO2A: [String]?
    let fileSizeBytes: String?
    let sellerURL: String?
    let formattedPrice, contentAdvisoryRating: String?
    let userRatingCountForCurrentVersion: Int?
    let trackViewURL: String?
    let trackContentRating: String?
    let currentVersionReleaseDate: Date?
    let description: String?
    let artistID: Int?
    let artistName: String?
    let genres: [String]?
    let price: Int?
    let currency, releaseNotes, bundleID: String?
    let releaseDate: Date?
    let trackName: String?
    let trackID: Int?
    let genreIDS: [String]?
    let sellerName, version, wrapperType: String?
    let userRatingCount: Int?
}

// MARK: - LookupResponse
struct LookupResponse2: Codable {
    let resultCount: Int
    let results: [Result2]
}

// MARK: - Result
struct Result2: Codable, Hashable {
    static func == (lhs: Result2, rhs: Result2) -> Bool {
        lhs.bundleID == rhs.bundleID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
    
    let screenshotUrls: [String]
    let ipadScreenshotUrls, appletvScreenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let artistViewURL: String
    let isGameCenterEnabled: Bool
    let features: [String]
    let advisories: [String]
    let supportedDevices: [String]
    let kind: String
    let averageUserRatingForCurrentVersion, averageUserRating: Double
    let trackCensoredName: String
    let languageCodesISO2A: [String]
    let fileSizeBytes: String
    let sellerURL: String
    let formattedPrice, contentAdvisoryRating: String
    let userRatingCountForCurrentVersion: Int
    let trackViewURL: String
    let trackContentRating: String
    let currentVersionReleaseDate: Date
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price: Int
    let description, currency: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let releaseDate: Date
    let bundleID, trackName: String
    let genreIDS: [String]
    let sellerName: String
    let trackID: Int
    let releaseNotes, primaryGenreName: String
    let primaryGenreID: Int
    let minimumOSVersion, version, wrapperType: String
    let userRatingCount: Int

    enum CodingKeys: String, CodingKey {
        case screenshotUrls, ipadScreenshotUrls, appletvScreenshotUrls, artworkUrl60, artworkUrl512, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case isGameCenterEnabled, features, advisories, supportedDevices, kind, averageUserRatingForCurrentVersion, averageUserRating, trackCensoredName, languageCodesISO2A, fileSizeBytes
        case sellerURL = "sellerUrl"
        case formattedPrice, contentAdvisoryRating, userRatingCountForCurrentVersion
        case trackViewURL = "trackViewUrl"
        case trackContentRating, currentVersionReleaseDate
        case artistID = "artistId"
        case artistName, genres, price, description, currency, isVppDeviceBasedLicensingEnabled, releaseDate
        case bundleID = "bundleId"
        case trackName
        case genreIDS = "genreIds"
        case sellerName
        case trackID = "trackId"
        case releaseNotes, primaryGenreName
        case primaryGenreID = "primaryGenreId"
        case minimumOSVersion = "minimumOsVersion"
        case version, wrapperType, userRatingCount
    }
}
