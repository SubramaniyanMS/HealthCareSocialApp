import Foundation
import Combine

@MainActor
final class ChatViewModel: ObservableObject {

    @Published var messages: [ChatMessage] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let aiService: AIServiceProtocol

    init(aiService: AIServiceProtocol = AIService()) {
        self.aiService = aiService

        let greeting = ChatMessage(
            role: .assistant,
            content: "Hello! 👋 I'm your Healthcare Assistant. I can help with healthcare-related questions about diseases, symptoms, prevention, nutrition, fitness, and general wellness. How can I help you today?"
        )
        messages.append(greeting)
    }

    // MARK: - Send message

    func sendMessage(_ text: String) async {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            errorMessage = "Please enter a question."
            return
        }

        guard !isLoading else { return }

        errorMessage = nil

        let userMessage = ChatMessage(role: .user, content: trimmed)
        messages.append(userMessage)

        isLoading = true
        defer { isLoading = false }

        do {
            let reply = try await aiService.sendMessage(messages: messages)
            let assistantMessage = ChatMessage(role: .assistant, content: reply)
            messages.append(assistantMessage)
        } catch {
            errorMessage = "Unable to get a response. Please try again."
            messages.removeLast()
        }
    }

    func clearError() {
        errorMessage = nil
    }
}
