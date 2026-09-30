import Foundation

final class APIClient {

    static let shared = APIClient()

    static let mediaBaseURL = "https://wavedinblobs.blob.core.windows.net/wavedinblobs/"

    // MARK: - URLSession
    private let session: URLSession

    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        session = URLSession(configuration: config)
    }

    // MARK: - Request

    func request<T: Decodable>(
        url: URL,
        method: String = "GET",
        headers: [String: String] = [:],
        body: Data? = nil
    ) async throws -> T {

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = body
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        do {
            let (data, response) = try await session.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            switch httpResponse.statusCode {
            case 200...299:
                break
            case 401:
                throw APIError.unauthorized
            default:
                throw APIError.httpError(statusCode: httpResponse.statusCode)
            }

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw APIError.decodingError(error)
            }

        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }


    static func fullMediaURL(from path: String?) -> URL? {
        guard let path = path, !path.isEmpty else { return nil }
        if path.hasPrefix("http://") || path.hasPrefix("https://") {
            return URL(string: path)
        }
        return URL(string: mediaBaseURL + path)
    }

    static func fullProfilePicURL(from path: String?) -> URL? {
        fullMediaURL(from: path)
    }
}
