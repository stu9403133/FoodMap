//
//  FavoriteView.swift
//  FoodMap
//
//  Created by 涂羽華 on 2026/2/11.
//

import SwiftUI

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

#Preview {
    FavoritesView()
}
