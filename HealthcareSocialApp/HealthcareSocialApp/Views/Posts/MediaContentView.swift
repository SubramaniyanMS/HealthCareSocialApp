//
//  MediaContentView.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import SwiftUI

struct MediaContentView: View {

    let post: Feed

    var body: some View {
        Group {
            switch post.mediaType {
            case 1:
                EmptyView()

            case 2:
                if let url = post.fullMediaURL {
                    ImagePostView(url: url)
                }

            case 3:
                if let url = post.fullMediaURL {
                    VideoPostView(url: url)
                } else {
                    mediaUnavailable(label: "Unable to play this video.",
                                     icon: "video.slash")
                }

            case 4:
                if let url = post.fullMediaURL {
                    AudioPostView(url: url)
                } else {
                    mediaUnavailable(label: "Unable to play audio.",
                                     icon: "speaker.slash")
                }

            case 5:
                if let url = post.fullMediaURL {
                    PDFPostView(url: url)
                } else {
                    mediaUnavailable(label: "Unable to load document.",
                                     icon: "doc.slash")
                }

            default:
                if post.hasMedia {
                    UnsupportedMediaView()
                }
            }
        }
    }

    // MARK: - Unavailable

    private func mediaUnavailable(label: String, icon: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
            Text(label)
        }
        .font(.caption)
        .foregroundStyle(.secondary)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Unsupported media type

struct UnsupportedMediaView: View {
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "questionmark.circle")
            Text("Unsupported media type")
        }
        .font(.caption)
        .foregroundStyle(.secondary)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
