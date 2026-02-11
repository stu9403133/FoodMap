//
//  MainTabView.swift
//  FoodMap
//
//  主頁面 - 包含四個 Tab
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1: 首頁
            HomeView()
                .tabItem {
                    Label("首頁", systemImage: "house.fill")
                }
                .tag(0)
            
            // Tab 2: 探索
            ExploreView()
                .tabItem {
                    Label("探索", systemImage: "map.fill")
                }
                .tag(1)
            
            // Tab 3: 收藏
            FavoritesView()
                .tabItem {
                    Label("收藏", systemImage: "heart.fill")
                }
                .tag(2)
            
            // Tab 4: 個人
            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person.fill")
                }
                .tag(3)
        }
        .accentColor(Color("Primary"))
    }
}

// MARK: - Tab Views (暫時用佔位符)









#Preview {
    MainTabView()
}
