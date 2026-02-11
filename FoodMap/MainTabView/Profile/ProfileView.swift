//
//  ProfileView.swift
//  FoodMap
//
//  Created by 涂羽華 on 2026/2/11.
//

import SwiftUI

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
    ProfileView()
}
