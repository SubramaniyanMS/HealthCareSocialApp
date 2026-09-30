//
//  VideoPostView.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import SwiftUI
import AVKit
import Combine

struct VideoPostView: View {

    let url: URL

    @State private var player: AVPlayer
    @State private var loadFailed = false
    @State private var statusObserver: AnyCancellable?

    init(url: URL) {
        self.url = url
        _player = State(initialValue: AVPlayer(url: url))
    }

    var body: some View {
        Group {
            if loadFailed {
                HStack(spacing: 8) {
                    Image(systemName: "video.slash.fill")
                    Text("Unable to play this video.")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                VideoPlayer(player: player)
                    .frame(height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
                    .onAppear {
                        observePlayerStatus()
                    }
                    .onDisappear {
                        player.pause()
                        statusObserver = nil
                    }
            }
        }
    }

    // MARK: - Private

    /// Observes the AVPlayerItem status to detect genuine playback failures.
    ///
    /// HLS (.m3u8) streams load tracks adaptively at runtime, so querying
    /// `loadTracks(withMediaType:)` before playback always returns an empty
    /// array — even for valid streams. Observing the item's `.status` property
    /// is the correct way to detect a real failure without false positives.
    private func observePlayerStatus() {
        guard let item = player.currentItem else { return }

        statusObserver = item.publisher(for: \.status)
            .receive(on: DispatchQueue.main)
            .sink { status in
                if status == .failed {
                    loadFailed = true
                }
            }
    }
}
