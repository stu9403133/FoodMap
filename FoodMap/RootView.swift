//
//  RootView.swift
//  FoodMap
//
//  根視圖 - 控制登入/主頁的切換
//

import SwiftUI

struct RootView: View {
    // 使用 AppStorage 持久化登入狀態
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = false
    
    var body: some View {
        ZStack {
            if isUserLoggedIn {
                // 已登入 → 顯示主頁面
                MainTabView()
                    .transition(.move(edge: .trailing))
            } else {
                // 未登入 → 顯示登入頁
                InstructionView(isUserLoggedIn: $isUserLoggedIn)
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isUserLoggedIn)
    }
}

#Preview {
    RootView()
}
