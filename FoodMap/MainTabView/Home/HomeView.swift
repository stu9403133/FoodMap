//
//  HomeView.swift
//  FoodMap
//
//  Created by 涂羽華 on 2026/2/11.
//

import SwiftUI

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

#Preview {
    HomeView()
}
