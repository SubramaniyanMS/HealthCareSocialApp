//
//  ImagePostView.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import SwiftUI

struct ImagePostView: View {

    let url: URL

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {

            case .empty:
                ZStack {
                    Color(.secondarySystemBackground)
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.08), radius: 4, y: 2)

            case .failure:
                ContentUnavailableView(
                    "Image unavailable",
                    systemImage: "photo.badge.exclamationmark",
                    description: Text("The image could not be loaded.")
                )
                .frame(height: 140)

            @unknown default:
                EmptyView()
            }
        }
    }
}
