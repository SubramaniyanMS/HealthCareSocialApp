//
//  PostListViewModel.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import Foundation
import Combine

@MainActor
final class PostListViewModel: ObservableObject {

    @Published var posts: [Feed] = []
    @Published var isLoading: Bool = false
    @Published var hasMorePages: Bool = true
    @Published var errorMessage: String?
    @Published var paginationError: String?

    private var nextPageCursor: Int = 1
    private var totalPages: Int = Int.max

    private let postService: PostServiceProtocol
    private let authManager: FirebaseAuthManager

    init(
        postService: PostServiceProtocol = MockPostService(),
        authManager: FirebaseAuthManager = .shared
    ) {
        self.postService = postService
        self.authManager = authManager
    }


    func loadInitialPosts() async {
        guard posts.isEmpty else { return }
        await loadNextPage()
    }

    // MARK: - Pagination

    func loadNextPage() async {
        guard !isLoading else { return }
        guard hasMorePages else { return }     

        isLoading = true
        paginationError = nil

        defer { isLoading = false }

        do {
            let token = try await bearerToken()
            let feedData = try await postService.fetchPosts(
                nextPage: nextPageCursor,
                bearerToken: token
            )

            let newFeeds = feedData.feeds ?? []
            posts.append(contentsOf: newFeeds)

            if let paginator = feedData.paginator {
                let reportedTotal = paginator.totalPages ?? totalPages
                totalPages = reportedTotal

                let nextFromAPI = paginator.nextPage ?? 0
                nextPageCursor = nextFromAPI

                if nextFromAPI == 0 || nextFromAPI > reportedTotal {
                    hasMorePages = false
                }
            }

            if newFeeds.isEmpty {
                hasMorePages = false
            }

        } catch {
            if posts.isEmpty {
                errorMessage = "Unable to load posts.\n\(error.localizedDescription)"
            } else {
                paginationError = "Unable to load more posts. Tap to retry."
            }
        }
    }


    func retryInitialLoad() async {
        errorMessage = nil
        posts = []
        nextPageCursor = 1
        totalPages = Int.max
        hasMorePages = true
        await loadNextPage()
    }

    func retryPagination() async {
        paginationError = nil
        await loadNextPage()
    }


    func signOut() {
        try? authManager.signOut()
    }


    private func bearerToken() async throws -> String {
        if let cached = authManager.bearerToken, !cached.isEmpty {
            return cached
        }
        return try await authManager.freshToken()
    }
}
