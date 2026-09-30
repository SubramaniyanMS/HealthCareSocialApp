//
//  HealthcareSocialAppApp.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import SwiftUI
import FirebaseCore

@main
struct HealthcareSocialAppApp: App {

    @StateObject private var authManager = FirebaseAuthManager.shared

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authManager)
        }
    }
}

// MARK: - RootView

struct RootView: View {

    @EnvironmentObject var authManager: FirebaseAuthManager

    var body: some View {
        Group {
            if authManager.isLoggedIn {
                MainTabView()
            } else {
                LoginView()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: authManager.isLoggedIn)
    }
}
