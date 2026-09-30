//
//  MainTabView.swift
//  HealthcareSocialApp
//
//  Created by Apple on 29/09/26.
//

import SwiftUI

struct MainTabView: View {

    var body: some View {
        TabView {
            PostListView()
                .tabItem {
                    Label("Feed", systemImage: "house.fill")
                }
                .tag(0)

            ChatView()
                .tabItem {
                    Label("Chat", systemImage: "brain.head.profile")
                }
                .tag(1)
        }
        .tint(Color(hex: "#0077b6") ?? .blue)
    }
}

#Preview {
    MainTabView()
}
