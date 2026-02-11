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
            HStack {
                nearRestaurantButton
                Spacer()
            }
            
            HStack {
                searchRestaurantButton
                Spacer(minLength: 10)
                microphoneButton
            }
            
            HStack {
                favoriteRestaurantButton
                Spacer()
                reLoadButton
            }
            
            Rectangle().foregroundColor(.chipBackground)
            
            Divider()
            
            Text("下方內容")
            nearRestaurantPageButton
        }
    }
}

private var nearRestaurantButton: some View {
    Button {
        // 按鈕動作
        print("按下附近的餐廳")
    } label: {
        HStack {
            Image(systemName: "house.fill").foregroundColor(Color("Primary"))
            Text("附近的餐廳").foregroundColor(Color.black)
            Image(systemName: "chevron.down").foregroundColor(Color("Primary"))
        }
        .font(.title2)
    }
}

private var searchRestaurantButton: some View {
    Button {
        print("按下搜尋附近餐廳")
    } label: {
        HStack {
            Text("搜尋餐廳").foregroundColor(Color.black)
            Spacer()
            Image(systemName: "magnifyingglass").foregroundColor(Color.black)
            
        }
        .font(.title2)
        .padding(16)
    }
    .foregroundColor(.backgroundDivider)
    .overlay {
        Rectangle().opacity(0.1)
    }
    .cornerRadius(16)
}

private var microphoneButton: some View {
    Button {
        print("點擊麥克風button")
    } label: {
        Image(systemName: "microphone.fill").foregroundColor(Color("Primary"))
    }
    .font(.title2)
    .padding(16)
    .foregroundColor(.backgroundDivider)
    .overlay {
        Rectangle().opacity(0.1)
    }
    .cornerRadius(16)
}

private var favoriteRestaurantButton: some View {
    Button {
        // 按鈕動作
        print("按下附近的餐廳")
    } label: {
        HStack {
            Image(systemName: "house.fill").foregroundColor(Color("Primary"))
            Text("最愛清單的人氣餐廳").foregroundColor(Color.black)
            Image(systemName: "chevron.down").foregroundColor(Color("Primary"))
        }
        .font(.title2)
    }
}

private var reLoadButton: some View {
    Button {
        print("reload button")
    } label: {
        Image(systemName: "arrow.clockwise.circle").foregroundColor(Color.black)
    }
    .font(.title)
    .padding(16)
}

//private var nearRestaurantPageButton: some View {
//    Button {
//        print("按下去附近餐廳頁面")
//    } label: {
//        HStack {
//            Spacer()
//            Text("附近的餐廳").foregroundColor(Color.black)
//            Spacer()
//            
//            ZStack {
//                Rectangle().foregroundColor(Color("Primary")).frame(width: 30, height: 30)
//                Image(systemName: "magnifyingglass").foregroundColor(Color.black)
//            }
//            
//            
//        }
//        .font(.title2)
////        .padding(30)
//    }
//    .border(Color.gray.opacity(0.3), width: 2)
//    .cornerRadius(16)
//}
private var nearRestaurantPageButton: some View {
    Button {
        print("按下去附近餐廳頁面")
    } label: {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Spacer()
                Text("附近的餐廳")
                    .foregroundColor(.black)
                Spacer()
                
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("Primary"))
                        .frame(width: geometry.size.height) // ✅ 寬度 = 高度（正方形）
                        .cornerRadius(16)
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                }
            }
        }
        .font(.title2)
        .frame(height: 60)
    }
    .overlay {
        RoundedRectangle(cornerRadius: 16)
            .stroke(Color.gray.opacity(0.3), lineWidth: 2)
    }
    
}


#Preview {
    HomeView()
}
