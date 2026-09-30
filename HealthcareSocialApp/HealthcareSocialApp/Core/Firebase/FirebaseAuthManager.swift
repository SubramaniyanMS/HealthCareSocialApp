import Foundation
import FirebaseAuth
import Combine

@MainActor
final class FirebaseAuthManager: ObservableObject {

    static let shared = FirebaseAuthManager()

    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?

    @Published var bearerToken: String?

    private var authStateHandle: AuthStateDidChangeListenerHandle?

    private init() {
        listenToAuthState()
    }


    private func listenToAuthState() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor [weak self] in
                self?.currentUser = user
                self?.isLoggedIn = (user != nil)
                if let user = user {
                    self?.bearerToken = try? await user.getIDToken()
                } else {
                    self?.bearerToken = nil
                }
            }
        }
    }

    // MARK: - Public API

    func signIn(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        currentUser = result.user
        bearerToken = try? await result.user.getIDToken()
        isLoggedIn = true
    }

    func signOut() throws {
        try Auth.auth().signOut()
        currentUser = nil
        bearerToken = nil
        isLoggedIn = false
    }

    func freshToken() async throws -> String {
        guard let user = Auth.auth().currentUser else {
            throw APIError.unauthorized
        }
        let token = try await user.getIDToken(forcingRefresh: false)
        bearerToken = token
        return token
    }

    deinit {
        if let handle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
