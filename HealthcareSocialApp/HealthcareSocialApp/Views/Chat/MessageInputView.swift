import SwiftUI

struct MessageInputView: View {

    @Binding var text: String
    let isLoading: Bool
    let onSend: () -> Void

    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 10) {
            TextField("Ask a healthcare question…", text: $text, axis: .vertical)
                .lineLimit(1...5)
                .focused($isFocused)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .submitLabel(.send)
                .onSubmit {
                    sendIfValid()
                }

            Button {
                isFocused = false
                sendIfValid()
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(canSend
                                     ? (Color(hex: "#0077b6") ?? .blue)
                                     : Color.secondary)
                    .animation(.easeInOut(duration: 0.15), value: canSend)
            }
            .disabled(!canSend)
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.bar)
    }

    private var canSend: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isLoading
    }

    private func sendIfValid() {
        guard canSend else { return }
        onSend()
    }
}
