import Foundation

// MARK: - Protocol

protocol PostServiceProtocol {
    func fetchPosts(nextPage: Int, bearerToken: String) async throws -> FeedData
}

// MARK: - Implementation

final class PostService: PostServiceProtocol {

    private let client: APIClient
    private let endpoint = URL(string: "https://mobileapidev.wavedin.app/api/Post/home")!

    init(client: APIClient = .shared) {
        self.client = client
    }

    func fetchPosts(nextPage: Int, bearerToken: String) async throws -> FeedData {

        let paginator = PaginatorRequest(
            pageSize: 20,
            pageNumber: 1,
            totalPages: 1,
            nextPage: nextPage,
            previousPage: max(0, nextPage - 1)
        )

        let requestBody = PostRequest(
            paginator: paginator,
            postCategoryType: 2,
            postType: 1,
            tagId: "",
            coordinates: [0.0, 0.0],
            enableUserTagBasedFilter: 1
        )

        let bodyData = try JSONEncoder().encode(requestBody)

        let response: HealthData = try await client.request(
            url: endpoint,
            method: "POST",
            headers: ["Authorization": "Bearer \(bearerToken)"],
            body: bodyData
        )

        guard let data = response.data else {
            throw APIError.noData
        }

        return data
    }
}
