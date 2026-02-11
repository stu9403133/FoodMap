//
//  AuthorityView.swift
//  FoodMap
//
//  Created by 涂羽華 on 2026/2/9.
//

import SwiftUI
import Lottie

struct AuthorityView: View {
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = AuthorityProcess()
    @State private var isPressed = false
    @FocusState private var focusedField: Field?
    
    enum Field {
        case userName
        case password
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            backgroundView
            
            ScrollView(showsIndicators: false) {
                VStack {
                    headerView
                    animationView
                    formView
                    loginButton
                }
                .padding(.top, 60)
            }
            
            // Loading Overlay
            if viewModel.isLoading {
                loadingOverlay
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .alert("登入失敗", isPresented: $viewModel.showError) {
            Button("確定", role: .cancel) {
                viewModel.clearError()
            }
        } message: {
            Text(viewModel.errorMessage ?? "未知錯誤")
        }
    }
    
    // MARK: - Subviews
    
    private var backgroundView: some View {
        Image(colorScheme == .dark ? "img_bg_blurry_dark" : "img_bg_blurry_light")
            .resizable()
            .ignoresSafeArea()
    }
    
    private var headerView: some View {
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
    }
    
    private var animationView: some View {
        LottieView(animation: .named("login"))
            .configure(\.contentMode, to: .scaleAspectFit)
            .looping()
            .frame(maxWidth: 300, maxHeight: 300)
    }
    
    private var formView: some View {
        VStack {
            VStack {
                // 使用者名稱欄位
                userNameField
                
                // 密碼欄位
                passwordField
            }
            .padding(.bottom, 20)
            
            // 記住我選項
            rememberMeToggle
        }
        .padding(.horizontal, 40)
    }
    
    private var userNameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("使用者名稱")
                .foregroundColor(Color("Primary"))
            
            TextField("輸入使用者名稱", text: $viewModel.userName)
                .focused($focusedField, equals: .userName)
                .multilineTextAlignment(.center)
                .padding(.vertical, 16)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            focusedField == .userName ? Color("Primary") : Color.gray.opacity(0.5),
                            lineWidth: 2
                        )
                )
                .textContentType(.username)
                .autocapitalization(.none)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .password
                }
        }
        .padding(.bottom, 15)
    }
    
    private var passwordField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("密碼")
                .foregroundColor(Color("Primary"))
            
            SecureField("輸入你的密碼", text: $viewModel.password)
                .focused($focusedField, equals: .password)
                .multilineTextAlignment(.center)
                .padding(.vertical, 16)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            focusedField == .password ? Color("Primary") : Color.gray.opacity(0.5),
                            lineWidth: 2
                        )
                )
                .textContentType(.password)
                .submitLabel(.go)
                .onSubmit {
                    if viewModel.canSubmit {
                        performLogin()
                    }
                }
        }
    }
    
    private var rememberMeToggle: some View {
        HStack {
            Button(action: {
                viewModel.isRemembered.toggle()
            }) {
                HStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                            .frame(width: 24, height: 24)
                        
                        if viewModel.isRemembered {
                            Circle()
                                .fill(Color("Primary"))
                                .frame(width: 14, height: 14)
                        }
                    }
                    
                    Text("記住我")
                        .foregroundColor(.primary)
                }
            }
            Spacer()
        }
    }
    
    private var loginButton: some View {
        HStack {
            Spacer()
            
            Button(action: performLogin) {
                HStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                    Text(viewModel.isLoading ? "登入中..." : "登入")
                        .foregroundColor(.white)
                }
                .frame(width: 150, height: 60)
                .bold()
                .background(
                    viewModel.canSubmit ?
                    Color("Primary") : Color.gray.opacity(0.5)
                )
                .cornerRadius(16)
            }
            .disabled(!viewModel.canSubmit)
            .scaleEffect(isPressed ? 0.8 : 1.0)
            .animation(
                .spring(response: 0.3, dampingFraction: 0.6),
                value: isPressed
            )
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if viewModel.canSubmit {
                            isPressed = true
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                    }
            )
            
            Spacer()
        }
        .padding(20)
    }
    
    private var loadingOverlay: some View {
        Color.black.opacity(0.3)
            .ignoresSafeArea()
            .overlay(
                VStack(spacing: 20) {
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    Text("登入中...")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(30)
                .background(Color.black.opacity(0.7))
                .cornerRadius(16)
            )
    }
    
    // MARK: - Actions
    
    private func performLogin() {
        hideKeyboard()
        viewModel.login()
    }
    
    private func hideKeyboard() {
        focusedField = nil
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

// MARK: - Preview

#Preview {
    AuthorityView()
}


//
//struct AuthorityView: View {
//    
//    @ObservedObject var viewModel: AuthorityProcess
//    
//    @Environment(\.colorScheme) var colorScheme
//    @State private var isPressed = false
//    @State private var isRemembered = false
//    @State private var userName = ""
//    @State private var password = ""
//    // 新增：追蹤哪個欄位正在輸入
//    @FocusState private var focusedField: Field?
//    
//    enum Field {
//        case userName
//        case password
//    }
//    
//    var body: some View {
//        ZStack {
//            // 背景圖片
//            Image(
//                colorScheme == .dark
//                    ? "img_bg_blurry_dark" : "img_bg_blurry_light"
//            )
//            .resizable()
//            .ignoresSafeArea()
//            
//            ScrollView(showsIndicators: false) {
//                VStack {
//                    // 美食地圖標題
//                    HStack {
//                        Image("icon")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 50, height: 50)
//                        
//                        Text("美食地圖")
//                            .foregroundColor(Color("Primary"))
//                            .font(.largeTitle)
//                            .bold()
//                    }
//                    
//                    // 中間手機 動圖
//                    LottieView(animation: .named("login"))
//                        .configure(\.contentMode, to: .scaleAspectFit)
//                        .looping()
//                        .frame(maxWidth: 300, maxHeight: 300)
//                    
//                    VStack {
//                        VStack {
//                            /// MARK: 使用者名稱
//                            HStack {
//                                Text("使用者名稱")
//                                    .foregroundColor(Color("Primary"))
//                                Spacer()
//                            }
//                            
//                            TextField("輸入使用者名稱", text: $userName)
//                                .multilineTextAlignment(.center)
//                                .padding(.vertical, 16)
//                                .background(Color.gray.opacity(0.1))
//                                .cornerRadius(16)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 16)
//                                        .stroke(Color.gray.opacity(0.5), lineWidth: 2)
//                                )
//                                .padding(.bottom, 15)  // 只在這個 TextField 下方加間距
//                                .onTapGesture {
//                                    focusedField = .userName
//                                }
//                                .id("userName")
//                                .textContentType(.name)
//                                .submitLabel(.next)
//                                .onSubmit {
//                                    focusedField = .password
//                                }
//                            
//                            /// MARK: 密碼
//                            HStack {
//                                Text("密碼")
//                                    .foregroundColor(Color("Primary"))
//                                Spacer()
//                            }
//                            
//                            SecureField("輸入你的密碼", text: $password)
//                                .multilineTextAlignment(.center)
//                                .padding(.vertical, 16)
//                                .background(Color.gray.opacity(0.1))
//                                .cornerRadius(16)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 16)
//                                        .stroke(Color.gray.opacity(0.5), lineWidth: 2)
//                                )
//                                .onTapGesture {
//                                    focusedField = .password
//                                }
//                                .id("password")
//                                .ignoresSafeArea(.keyboard, edges: .top)
//                                .textContentType(.password)
//                                .submitLabel(.go)
//                                .onSubmit {
//                                    // action
//                                }
//                        }
//                        .padding(.bottom, 20)  // 只在這個 TextField 下方加間距
//                        
//                        HStack {
//                            // 在你的 VStack 中加入：
//                            Button(action: {
//                                isRemembered.toggle()
//                            }) {
//                                HStack(spacing: 8) {
//                                    ZStack {
//                                        Circle()
//                                            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
//                                            .frame(width: 24, height: 24)
//                                        
//                                        if isRemembered {
//                                            Circle()
//                                                .fill(Color("Primary"))
//                                                .frame(width: 14, height: 14)
//                                        }
//                                    }
//                                    
//                                    Text("記住我")
//                                        .foregroundColor(.primary)
//                                }
//                            }
//                            Spacer()
//                        }
//                        
//                        HStack {
//                            Spacer()
//                            NavigationLink(destination: InstructionView()) {
//                                Text("登入 / 註冊")
//                                    .foregroundColor(.white)
//                                    .frame(
//                                        width: 150,
//                                        height: 60,
//                                        alignment: .center
//                                    )
//                                    .bold()
//                                    .background(Color("Primary"))
//                                    .cornerRadius(16)
//                            }
//                            .scaleEffect(isPressed ? 0.8 : 1.0)
//                            .animation(
//                                .spring(response: 0.3, dampingFraction: 0.6),
//                                value: isPressed
//                            )
//                            .simultaneousGesture(
//                                DragGesture(minimumDistance: 0)
//                                    .onChanged { _ in
//                                        isPressed = true
//                                    }
//                                    .onEnded { _ in
//                                        isPressed = false
//                                    }
//                            )
//                            Spacer()
//                        }
//                        .padding(20)
//                    }
//                    .padding(.horizontal, 40)
//                    
//                }
//                .padding(.top, 60)
//            }
//        }
//        .onTapGesture {
//            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//        }
//    }
//
//}
//
//
//
//#Preview {
//    AuthorityView(viewModel: AuthorityProcess())
//}

