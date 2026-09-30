//
//  PostRowView.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import SwiftUI

struct PostRowView: View {

    let post: Feed

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack(alignment: .top, spacing: 10) {
                profileAvatar

                VStack(alignment: .leading, spacing: 2) {
                    Text(post.profileName ?? "Unknown")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text(post.displayDate)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }

            if let tag = post.tagName, !tag.isEmpty {
                Text("#\(tag)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(hex: "#0077b6") ?? .blue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill((Color(hex: "#0077b6") ?? .blue).opacity(0.1))
                    )
            }

            if let content = post.postContent, !content.isEmpty {
                Text(content)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            MediaContentView(post: post)

            HStack(spacing: 18) {
                statLabel(icon: "eye", count: post.viewCount ?? 0)
                statLabel(icon: "hand.raised", count: post.clapCount ?? 0)
                statLabel(icon: "bubble.left", count: post.commentCount ?? 0)
                Spacer()
            }
            .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(cardBackground)
    }

    // MARK: - Subviews

    private var profileAvatar: some View {
        AsyncImage(url: post.fullProfilePicURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .empty:
                ProgressView()
            default:
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 42, height: 42)
        .clipShape(Circle())
        .overlay(Circle().stroke(.quaternary, lineWidth: 1))
    }

    private func statLabel(icon: String, count: Int) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
            Text("\(count)")
                .font(.caption)
        }
    }

    private var cardBackground: some View {
        Group {
            if let hex = post.bgColor, !hex.isEmpty,
               let bg = Color(hex: hex) {
                bg.opacity(0.08)
            } else {
                Color.clear
            }
        }
    }
}

#Preview {
    PostRowView(post: Feed(
        allowAnonymous: false,
        postContent: "Sample post content about healthcare topics.",
        viewCount: 12, threadCount: 0, clapCount: 3,
        createdDate: 1784725300,
        coordinates: [0, 0],
        mediaURL: nil, mediaType: 1, postType: 3,
        postID: "preview-001",
        thumbNail: nil,
        profileName: "Health Expert",
        gender: 0,
        tagName: "Healthcare",
        profilePic: nil,
        bgColor: "#334257", textColor: "#ffffff",
        tagID: nil, userID: nil,
        nft: nil, monetize: nil, monetizeAmount: nil,
        monetizeActualAmount: nil, monetizePlatformAmount: nil,
        monetizeTax: nil, currencyCode: nil, currencySymbol: nil,
        score: nil, rating: nil, commentCount: 2, ratedUserCount: nil,
        threadID: nil, threadLimit: nil, isView: nil, isClap: nil
    ))
    .padding()
}
