import SwiftUI

struct ChatView: View {

    @StateObject private var viewModel = ChatViewModel()
    @State private var inputText: String = ""
    @Namespace private var bottomID

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            welcomeHeader

                            ForEach(viewModel.messages) { message in
                                ChatBubbleView(message: message)
                                    .padding(.horizontal, 16)
                                    .transition(.asymmetric(
                                        insertion: .move(edge: .bottom).combined(with: .opacity),
                                        removal: .opacity
                                    ))
                            }

                            if viewModel.isLoading {
                                TypingIndicatorView()
                                    .padding(.horizontal, 16)
                                    .transition(.opacity)
                                    .id("typing")
                            }

                            Color.clear
                                .frame(height: 1)
                                .id(bottomID)
                        }
                        .padding(.vertical, 12)
                    }
                    .onChange(of: viewModel.messages.count) {
                        withAnimation(.easeOut(duration: 0.3)) {
                            proxy.scrollTo(bottomID)
                        }
                    }
                    .onChange(of: viewModel.isLoading) {
                        withAnimation(.easeOut(duration: 0.3)) {
                            proxy.scrollTo(bottomID)
                        }
                    }
                }

                if let error = viewModel.errorMessage {
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.orange)
                        Text(error)
                            .font(.caption)
                            .foregroundStyle(.primary)
                        Spacer()
                        Button("Dismiss") {
                            viewModel.clearError()
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.systemOrange).opacity(0.12))
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                Divider()
                MessageInputView(
                    text: $inputText,
                    isLoading: viewModel.isLoading
                ) {
                    let text = inputText
                    inputText = ""
                    Task { await viewModel.sendMessage(text) }
                }
            }
            .navigationTitle("Healthcare Assistant")
            .navigationBarTitleDisplayMode(.inline)
            .animation(.easeInOut(duration: 0.2), value: viewModel.errorMessage)
            .animation(.easeInOut(duration: 0.2), value: viewModel.isLoading)
        }
    }

    // MARK: - Welcome header

    private var welcomeHeader: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "#0077b6") ?? .blue,
                                     Color(hex: "#00b4d8") ?? .cyan],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 70, height: 70)
                Image(systemName: "stethoscope")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .shadow(color: .blue.opacity(0.3), radius: 8, y: 4)

            Text("Healthcare Assistant")
                .font(.headline)
                .fontWeight(.semibold)

            Text("Ask me anything about health, symptoms,\nnutrition, medications, or wellness.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 32)
    }
}

#Preview {
    ChatView()
}
