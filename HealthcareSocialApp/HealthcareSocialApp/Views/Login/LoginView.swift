//
//  LoginView.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?

    private enum Field { case email, password }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#0f2027") ?? .black,
                         Color(hex: "#203a43") ?? .blue,
                         Color(hex: "#2c5364") ?? .teal],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    Spacer(minLength: 60)

                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(.white.opacity(0.1))
                                .frame(width: 90, height: 90)
                            Text("❤️")
                                .font(.system(size: 44))
                        }

                        Text("Health")
                            .font(.system(size: 38, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)

                        Text("Welcome Back")
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.75))
                    }

                    Spacer(minLength: 50)

                    VStack(spacing: 20) {

                        VStack(alignment: .leading, spacing: 6) {
                            Label("Email", systemImage: "envelope")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white.opacity(0.7))

                            TextField("email@example.com", text: $viewModel.email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .focused($focusedField, equals: .email)
                                .submitLabel(.next)
                                .onSubmit { focusedField = .password }
                                .padding()
                                .background(.white.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.white.opacity(0.2), lineWidth: 1)
                                )
                                .foregroundStyle(.white)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Label("Password", systemImage: "lock")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white.opacity(0.7))

                            SecureField("••••••••", text: $viewModel.password)
                                .focused($focusedField, equals: .password)
                                .submitLabel(.done)
                                .onSubmit { Task { await viewModel.login() } }
                                .padding()
                                .background(.white.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.white.opacity(0.2), lineWidth: 1)
                                )
                                .foregroundStyle(.white)
                        }

                        if let error = viewModel.errorMessage {
                            HStack(spacing: 6) {
                                Image(systemName: "exclamationmark.circle.fill")
                                Text(error)
                            }
                            .font(.caption)
                            .foregroundStyle(Color(hex: "#ff6b6b") ?? .red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                        }

                        Button {
                            focusedField = nil
                            Task { await viewModel.login() }
                        } label: {
                            Group {
                                if viewModel.isLoading {
                                    HStack(spacing: 10) {
                                        ProgressView()
                                            .tint(.white)
                                        Text("Logging in…")
                                    }
                                } else {
                                    Text("LOGIN")
                                        .fontWeight(.bold)
                                        .tracking(2)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "#00b4d8") ?? .cyan,
                                             Color(hex: "#0077b6") ?? .blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .disabled(viewModel.isLoading)
                        .buttonStyle(.plain)
                        .shadow(color: .blue.opacity(0.4), radius: 8, y: 4)
                    }
                    .padding(28)
                    .background(.white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.white.opacity(0.1), lineWidth: 1)
                    )
                    .padding(.horizontal, 24)

                    Spacer(minLength: 40)
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: viewModel.errorMessage)
    }
}

#Preview {
    LoginView()
}
