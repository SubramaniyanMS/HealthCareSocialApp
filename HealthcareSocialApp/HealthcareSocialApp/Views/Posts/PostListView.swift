//
//  PostListView.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import SwiftUI

struct PostListView: View {

    @StateObject private var viewModel = PostListViewModel()
    @EnvironmentObject private var authManager: FirebaseAuthManager
    @State private var showLogoutConfirmation = false

    var body: some View {
        NavigationStack {
            Group {
                if let error = viewModel.errorMessage, viewModel.posts.isEmpty {
                    errorView(message: error)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.posts) { post in
                                PostRowView(post: post)
                                    .onAppear {
                                        if post.id == viewModel.posts.last?.id {
                                            Task { await viewModel.loadNextPage() }
                                        }
                                    }
                                Divider().padding(.horizontal)
                            }
 
                            paginationFooter
                        }
                    }
                    .refreshable {
                        await viewModel.retryInitialLoad()
                    }
                }
            }
            .navigationTitle("Health Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showLogoutConfirmation = true
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundStyle(Color(hex: "#0077b6") ?? .blue)
                    }
                    .accessibilityLabel("Sign Out")
                }
            }
            .alert("Log Out", isPresented: $showLogoutConfirmation) {
                Button("Log Out", role: .destructive) {
                    viewModel.signOut()
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure you want to log out?")
            }
            .task {
                await viewModel.loadInitialPosts()
            }
        }
    }

    // MARK: - Pagination footer

    @ViewBuilder
    private var paginationFooter: some View {
        VStack(spacing: 0) {
            Divider()

            if viewModel.isLoading && !viewModel.posts.isEmpty {
                HStack(spacing: 10) {
                    ProgressView()
                        .scaleEffect(0.8)
                    Text("Loading more posts…")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 20)

            } else if let paginationError = viewModel.paginationError {
                VStack(spacing: 8) {
                    Text(paginationError)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                    Button("Retry") {
                        Task { await viewModel.retryPagination() }
                    }
                    .font(.caption)
                    .buttonStyle(.borderedProminent)
                    .tint(Color(hex: "#0077b6") ?? .blue)
                }
                .padding(.vertical, 20)
                .padding(.horizontal)

            } else if !viewModel.hasMorePages && !viewModel.posts.isEmpty {
                Text("No more posts")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 20)
            }
        }
    }

    // MARK: - Error view

    private func errorView(message: String) -> some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 50))
                .foregroundStyle(.secondary)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Button("Retry") {
                Task { await viewModel.retryInitialLoad() }
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(hex: "#0077b6") ?? .blue)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    PostListView()
        .environmentObject(FirebaseAuthManager.shared)
}
