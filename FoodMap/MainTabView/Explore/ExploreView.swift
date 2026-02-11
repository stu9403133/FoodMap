//
//  ExploreView.swift
//  FoodMap
//
//  Created by 涂羽華 on 2026/2/11.
//

import SwiftUI

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

#Preview {
    ExploreView()
}
