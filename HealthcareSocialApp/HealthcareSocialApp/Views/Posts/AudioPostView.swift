//
//  AudioPostView.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import SwiftUI
import AVFoundation
import Combine

// MARK: - AudioPlayerManager

@MainActor
final class AudioPlayerManager: NSObject, ObservableObject {

    @Published var isPlaying = false
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    @Published var loadFailed = false

    private var player: AVPlayer?
    private var timeObserverToken: Any?

    func setup(url: URL) {
        let item = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: item)

        Task {
            do {
                let asset = AVURLAsset(url: url)
                let d = try await asset.load(.duration)
                duration = d.seconds.isNaN ? 0 : d.seconds
            } catch {
                loadFailed = true
            }
        }

        let interval = CMTime(seconds: 0.5, preferredTimescale: 600)
        timeObserverToken = player?.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] time in
            Task { @MainActor [weak self] in
                self?.currentTime = time.seconds
            }
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinish),
            name: .AVPlayerItemDidPlayToEndTime,
            object: item
        )
    }

    func togglePlayPause() {
        guard let player else { return }
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
    }

    func seek(to time: Double) {
        let cmTime = CMTime(seconds: time, preferredTimescale: 600)
        player?.seek(to: cmTime)
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }

    @objc private func playerDidFinish() {
        isPlaying = false
        currentTime = 0
        player?.seek(to: .zero)
    }

    deinit {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
        }
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - AudioPostView

struct AudioPostView: View {

    let url: URL

    @StateObject private var manager = AudioPlayerManager()

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: "music.note")
                    .font(.title3)
                    .foregroundStyle(Color(hex: "#0077b6") ?? .blue)
                Text("Audio Post")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
            }

            if manager.loadFailed {
                HStack(spacing: 8) {
                    Image(systemName: "speaker.slash.fill")
                    Text("Unable to play audio.")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            } else {
                VStack(spacing: 6) {
                    Slider(
                        value: Binding(
                            get: { manager.currentTime },
                            set: { manager.seek(to: $0) }
                        ),
                        in: 0...max(manager.duration, 1)
                    )
                    .tint(Color(hex: "#0077b6") ?? .blue)

                    HStack {
                        Text(manager.currentTime.asAudioDuration)
                        Spacer()
                        Text(manager.duration.asAudioDuration)
                    }
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                }

                Button {
                    manager.togglePlayPause()
                } label: {
                    Image(systemName: manager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(Color(hex: "#0077b6") ?? .blue)
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .onAppear { manager.setup(url: url) }
        .onDisappear { manager.pause() }
    }
}
