import Foundation

// MARK: - Message role

enum ChatRole: String, Codable {
    case system
    case user
    case assistant
}

// MARK: - Chat message

struct ChatMessage: Identifiable, Codable {
    let id: UUID
    let role: ChatRole
    let content: String
    let timestamp: Date

    init(id: UUID = UUID(), role: ChatRole, content: String, timestamp: Date = .now) {
        self.id = id
        self.role = role
        self.content = content
        self.timestamp = timestamp
    }
}

// MARK: - OpenAI API request / response models

struct OpenAIMessage: Codable {
    let role: String
    let content: String
}

struct OpenAIChatRequest: Codable {
    let model: String
    let messages: [OpenAIMessage]
    let temperature: Double
    let maxTokens: Int

    enum CodingKeys: String, CodingKey {
        case model, messages, temperature
        case maxTokens = "max_tokens"
    }
}

struct OpenAIChatResponse: Codable {
    struct Choice: Codable {
        struct Message: Codable {
            let role: String
            let content: String
        }
        let message: Message
        let finishReason: String?

        enum CodingKeys: String, CodingKey {
            case message
            case finishReason = "finish_reason"
        }
    }
    let choices: [Choice]
}
