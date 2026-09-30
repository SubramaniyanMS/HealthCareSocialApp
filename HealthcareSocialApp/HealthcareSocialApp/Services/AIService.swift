import Foundation

// MARK: - Protocol (enables unit-test mocking)

protocol AIServiceProtocol {
    func sendMessage(messages: [ChatMessage]) async throws -> String
}

// MARK: - Implementation

final class AIService: AIServiceProtocol {

    // MARK: - Healthcare system prompt
    private static let systemPrompt = """
    You are a healthcare information assistant.

    Your sole purpose is to answer healthcare-related questions with accurate,
    general educational information. You may address:
    • Diseases and medical conditions
    • Symptoms and their possible causes
    • Prevention and healthy habits
    • Nutrition and fitness
    • Medications (general information only)
    • Medical terminology
    • Mental health awareness
    • General wellness

    Rules:
    1. Do NOT diagnose users or recommend specific treatments.
    2. Do NOT claim to replace a qualified doctor or medical professional.
    3. For any emergency, immediately advise the user to call emergency services
       or visit the nearest healthcare facility.
    4. If a question is unrelated to healthcare, respond exactly with:
       "I'm designed to assist with healthcare-related information only.
       Please ask a healthcare-related question."
    5. Keep responses clear, empathetic, and concise.
    """

    // MARK: - Configuration

    private let endpoint = URL(string: "https://api.openai.com/v1/chat/completions")!
    private let model = "gpt-4o-mini"
    private let apiKey: String

    init() {
        self.apiKey = Bundle.main.infoDictionary?["OPENAI_API_KEY"] as? String ?? ""
    }

    // MARK: - Send message

    func sendMessage(messages: [ChatMessage]) async throws -> String {

        guard !apiKey.isEmpty else {
            throw APIError.noToken
        }

        var openAIMessages: [OpenAIMessage] = [
            OpenAIMessage(role: ChatRole.system.rawValue, content: AIService.systemPrompt)
        ]

        let conversationMessages = messages
            .filter { $0.role != .system }
            .map { OpenAIMessage(role: $0.role.rawValue, content: $0.content) }

        openAIMessages.append(contentsOf: conversationMessages)

        let requestBody = OpenAIChatRequest(
            model: model,
            messages: openAIMessages,
            temperature: 0.7,
            maxTokens: 512
        )

        let bodyData = try JSONEncoder().encode(requestBody)

        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = bodyData
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 60

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpError(statusCode: httpResponse.statusCode)
        }

        let decoded = try JSONDecoder().decode(OpenAIChatResponse.self, from: data)

        guard let content = decoded.choices.first?.message.content else {
            throw APIError.noData
        }

        return content
    }
}
