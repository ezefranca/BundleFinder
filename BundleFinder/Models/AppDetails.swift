import Foundation

struct AppDetails: Identifiable, Codable {
    var id: UUID = UUID()
    let trackId: Int?
    let trackName: String?
    let artworkUrl100: String?
    let description: String?
    let sellerName: String?
    let releaseDate: String?
    let version: String?
    let bundleId: String?
    let searchedAppId: String

    init(from dict: [String: Any], searchedAppId: String) {
        self.trackId = dict["trackId"] as? Int
        self.trackName = dict["trackName"] as? String
        self.artworkUrl100 = dict["artworkUrl100"] as? String
        self.description = dict["description"] as? String
        self.sellerName = dict["sellerName"] as? String
        self.releaseDate = dict["releaseDate"] as? String
        self.version = dict["version"] as? String
        self.bundleId = dict["bundleId"] as? String
        self.searchedAppId = searchedAppId
    }

    func dictionaryRepresentation() -> [String: Any] {
        return [
            "trackId": trackId ?? 0,
            "trackName": trackName ?? "",
            "artworkUrl100": artworkUrl100 ?? "",
            "description": description ?? "",
            "sellerName": sellerName ?? "",
            "releaseDate": releaseDate ?? "",
            "version": version ?? "",
            "bundleId": bundleId ?? "",
            "searchedAppId": searchedAppId
        ]
    }
}
