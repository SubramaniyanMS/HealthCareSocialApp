//
//  LoginViewModel.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let authManager: FirebaseAuthManager

    init(authManager: FirebaseAuthManager = .shared) {
        self.authManager = authManager
    }

    func login() async {
        errorMessage = nil

        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please enter your email address."
            return
        }
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address."
            return
        }

        guard !password.isEmpty else {
            errorMessage = "Please enter your password."
            return
        }
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters."
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            try await authManager.signIn(email: email, password: password)
        } catch {
            errorMessage = friendlyErrorMessage(from: error)
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }

    private func friendlyErrorMessage(from error: Error) -> String {
        let desc = error.localizedDescription.lowercased()

        if desc.contains("password") || desc.contains("credential") || desc.contains("user") {
            return "Invalid email or password. Please try again."
        } else if desc.contains("network") || desc.contains("internet") {
            return "No internet connection. Please check your network and try again."
        } else {
            return "Login failed. Please try again."
        }
    }
}
