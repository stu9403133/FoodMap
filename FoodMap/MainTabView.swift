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

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "house.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color("Primary"))
                Text("首頁")
                    .font(.title)
                    .padding()
            }
            .navigationTitle("美食地圖")
        }
    }
}

struct ExploreView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "map.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color("Primary"))
                Text("探索")
                    .font(.title)
                    .padding()
            }
            .navigationTitle("探索美食")
        }
    }
}

struct FavoritesView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "heart.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color("Primary"))
                Text("收藏")
                    .font(.title)
                    .padding()
            }
            .navigationTitle("我的收藏")
        }
    }
}

struct ProfileView: View {
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "person.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color("Primary"))
                Text("個人資料")
                    .font(.title)
                    .padding()
                
                // 登出按鈕
                Button(action: logout) {
                    Text("登出")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("我的")
        }
    }
    
    private func logout() {
        withAnimation {
            isUserLoggedIn = false
        }
    }
}

#Preview {
    MainTabView()
}
