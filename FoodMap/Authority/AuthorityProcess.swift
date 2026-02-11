//
//  AuthorityProcess.swift
//  FoodMap
//
//  Created by 涂羽華 on 2026/2/10.
//

import Foundation
import SwiftUI
import Combine

// MARK: - ViewModel
class AuthorityProcess: ObservableObject {
    
    // MARK: - Published Properties (供 View 訂閱)
    // 新增：用於更新全局登入狀態
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = false
    /// Model 資料
    @Published private var model = AuthorityModel()
    
    /// View 可以直接綁定的屬性
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var isRemembered: Bool = false
    
    /// 狀態管理
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    
    // MARK: - Private Properties
    
    private var cancellables = Set<AnyCancellable>()
    private let userDefaults = UserDefaults.standard
    
    // UserDefaults Keys
    private let kSavedUserName = "saved_user_name"
    private let kIsRemembered = "is_remembered"
    
    // MARK: - Initialization
    
    init() {
        setupBindings()
        loadSavedCredentials()
    }
    
    // MARK: - Setup Bindings (設定 Combine 資料流)
    
    private func setupBindings() {
        // 監聽 userName 和 password 的變化，自動清除錯誤訊息
        Publishers.CombineLatest($userName, $password)
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] _, _ in
                self?.clearError()
            }
            .store(in: &cancellables)
        
        // 監聽 isRemembered 的變化
        $isRemembered
            .sink { [weak self] remembered in
                self?.userDefaults.set(remembered, forKey: self?.kIsRemembered ?? "")
                if !remembered {
                    self?.clearSavedCredentials()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public Methods (供 View 呼叫)
    
    /// 登入
    func login() {
        // 清除之前的錯誤
        clearError()
        
        // 開始載入
        isLoading = true
        
        // 驗證登入
        let result = model.validateLogin(userName: userName, password: password)
        
        // 模擬網路延遲 (實際應用中這會是 API 呼叫)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            self.isLoading = false
            
            switch result {
            case .success:
                self.handleLoginSuccess()
            case .failure(let error):
                self.handleLoginFailure(error: error)
            }
        }
    }
    
    /// 註冊
    func register() {
        // 註冊邏輯
    }
    
    /// 登出
    func logout() {
        if !isRemembered {
            clearCredentials()
        }
    }
    
    /// 清除錯誤訊息
    func clearError() {
        errorMessage = nil
        showError = false
    }
    
    // MARK: - Private Methods
    
    private func handleLoginSuccess() {
        isUserLoggedIn = true
        // 如果勾選「記住我」，儲存使用者名稱
        if isRemembered {
            saveCredentials()
        }
        
        // 更新 model
        model.userName = userName
        
        print("✅ 登入成功: \(userName)")
    }
    
    private func handleLoginFailure(error: LoginError) {
        errorMessage = error.errorDescription
        showError = true
        
        print("❌ 登入失敗: \(error.errorDescription ?? "Unknown error")")
    }
    
    // MARK: - UserDefaults Management
    
    private func saveCredentials() {
        userDefaults.set(userName, forKey: kSavedUserName)
        userDefaults.set(true, forKey: kIsRemembered)
    }
    
    private func loadSavedCredentials() {
        let remembered = userDefaults.bool(forKey: kIsRemembered)
        isRemembered = remembered
        
        if remembered {
            userName = userDefaults.string(forKey: kSavedUserName) ?? ""
        }
    }
    
    private func clearSavedCredentials() {
        userDefaults.removeObject(forKey: kSavedUserName)
        userDefaults.set(false, forKey: kIsRemembered)
    }
    
    private func clearCredentials() {
        userName = ""
        password = ""
    }
    
    // MARK: - Validation Helpers (即時驗證，可選用)
    
    /// 使用者名稱是否有效
    var isUserNameValid: Bool {
        !userName.isEmpty && userName.count >= 3
    }
    
    /// 密碼是否有效
    var isPasswordValid: Bool {
        !password.isEmpty && password.count >= 6
    }
    
    /// 表單是否可以提交
    var canSubmit: Bool {
        isUserNameValid && isPasswordValid && !isLoading
    }
}
