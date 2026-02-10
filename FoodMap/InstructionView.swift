//
//  ContentView.swift
//  FoodMap
//
//  Created by 涂羽華 on 2026/2/9.
//

import Lottie
import SwiftUI

struct InstructionView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isPressed = false
    
    // 接收來自 RootView 的登入狀態綁定
    @Binding var isUserLoggedIn: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(
                    colorScheme == .dark
                        ? "img_bg_blurry_dark" : "img_bg_blurry_light"
                )
                .resizable()
                .ignoresSafeArea()

                VStack {
                    HStack {
                        Image("icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)

                        Text("美食地圖")
                            .foregroundColor(Color("Primary"))
                            .font(.largeTitle)
                            .bold()
                    }

                    VStack {
                        LottieView(animation: .named("introduction"))
                            .configure(\.contentMode, to: .scaleAspectFit)
                            .looping()
                            .frame(maxWidth: 500)
                    }
                    .padding()

                    Spacer()

                    VStack {
                        Text("不知道要吃什麼嗎？")
                            .foregroundColor(Color("Primary"))

                        HStack {
                            Spacer()
                            VStack {
                                LottieView(animation: .named("arrow"))
                                    .configure(
                                        \.contentMode,
                                        to: .scaleAspectFit
                                    )
                                    .looping()
                                    .frame(maxWidth: 100, maxHeight: 100)
                            }
                        }

                        HStack {
                            Spacer()
                            NavigationLink(destination: AuthorityView()) {
                                Text("下一步")
                                    .foregroundColor(.white)
                                    .frame(
                                        width: 150,
                                        height: 60,
                                        alignment: .center
                                    )
                                    .bold()
                                    .background(Color("Primary"))
                                    .cornerRadius(16)
                            }
                            .scaleEffect(isPressed ? 0.8 : 1.0)
                            .animation(
                                .spring(response: 0.3, dampingFraction: 0.6),
                                value: isPressed
                            )
                            .simultaneousGesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { _ in
                                        isPressed = true
                                    }
                                    .onEnded { _ in
                                        isPressed = false
                                    }
                            )
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    InstructionView(isUserLoggedIn: .constant(false))
}
