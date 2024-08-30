import Foundation
import GZIP

class NetworkManager {
    
    private let baseUrl = "https://itunes.apple.com/lookup"

    func fetchAppDetails(appId: String, completion: @escaping (AppDetails?) -> Void) async {
        guard let url = buildURL(with: appId) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        do {
            let (data, response) = try await sendRequest(url: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid HTTP response")
                completion(nil)
                return
            }

            guard httpResponse.statusCode == 200 else {
                print("Failed with status code: \(httpResponse.statusCode)")
                completion(nil)
                return
            }

            let decodedData = try handleGzipResponse(data: data, response: httpResponse)

            if let jsonDict = try JSONSerialization.jsonObject(with: decodedData, options: []) as? [String: Any] {
                if let results = jsonDict["results"] as? [[String: Any]], let firstResult = results.first {
                    let appDetails = AppDetails(from: firstResult, searchedAppId: appId)
                    completion(appDetails)
                } else {
                    completion(nil)
                }
            } else {
                print("Failed to cast JSON to dictionary")
                completion(nil)
            }

        } catch {
            print("Failed to fetch data: \(error.localizedDescription)")
            completion(nil)
        }
    }

    private func sendRequest(url: URL) async throws -> (Data, URLResponse) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Add necessary headers
        request.addValue("itunes.apple.com", forHTTPHeaderField: "Host")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
        request.addValue("\"Chromium\";v=\"116\", \"Not)A;Brand\";v=\"24\", \"Google Chrome\";v=\"116\"", forHTTPHeaderField: "sec-ch-ua")
        request.addValue("?0", forHTTPHeaderField: "sec-ch-ua-mobile")
        request.addValue("\"macOS\"", forHTTPHeaderField: "sec-ch-ua-platform")
        request.addValue("1", forHTTPHeaderField: "Upgrade-Insecure-Requests")
        request.addValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
        request.addValue("text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7", forHTTPHeaderField: "Accept")
        request.addValue("none", forHTTPHeaderField: "Sec-Fetch-Site")
        request.addValue("navigate", forHTTPHeaderField: "Sec-Fetch-Mode")
        request.addValue("?1", forHTTPHeaderField: "Sec-Fetch-User")
        request.addValue("document", forHTTPHeaderField: "Sec-Fetch-Dest")
        request.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        request.addValue("en-GB,en-US;q=0.9,en;q=0.8", forHTTPHeaderField: "Accept-Language")

        return try await session.data(for: request)
    }

    private func handleGzipResponse(data: Data, response: HTTPURLResponse) throws -> Data {
        guard let contentEncoding = response.value(forHTTPHeaderField: "Content-Encoding"),
              contentEncoding == "gzip" else {
            return data
        }

        return NSData(data: data).gunzipped() ?? Data()
    }

    private func buildURL(with appId: String) -> URL? {
        let urlParams = ["id": appId]
        return URL(string: baseUrl)?.appendingQueryParameters(urlParams)
    }
}

// Result model and URLQueryParameterStringConvertible extension should be defined similarly as previously provided.

// Extension for URL query parameters
protocol URLQueryParameterStringConvertible {
    var queryParameters: String { get }
}

extension Dictionary: URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let keyString = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let valueString = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            parts.append("\(keyString)=\(valueString)")
        }
        return parts.joined(separator: "&")
    }
}

extension URL {
    func appendingQueryParameters(_ parametersDictionary: Dictionary<String, String>) -> URL {
        let urlString = "\(self.absoluteString)?\(parametersDictionary.queryParameters)"
        return URL(string: urlString)!
    }
}
