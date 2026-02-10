//
//  AuthorityModel.swift
//  FoodMap
//
//  Created by 涂羽華 on 2026/2/10.
//

import Foundation

// MARK: - Model (資料模型)
struct AuthorityModel: Codable {
    var userName: String
    var password: String
    var isAuthorized: Bool
    
    init(userName: String = "", password: String = "", isAuthorized: Bool = false) {
        self.userName = userName
        self.password = password
        self.isAuthorized = isAuthorized
    }
    
    // 驗證登入資訊
    func validateLogin(userName: String, password: String) -> LoginResult {
        // 基本驗證規則
        guard !userName.isEmpty else {
            return .failure(.emptyUserName)
        }
        
        guard !password.isEmpty else {
            return .failure(.emptyPassword)
        }
        
        guard userName.count >= 3 else {
            return .failure(.userNameTooShort)
        }
        
        guard password.count >= 6 else {
            return .failure(.passwordTooShort)
        }
        
        // TODO: 這裡應該要呼叫 API 驗證
        // 目前先用模擬驗證 (可以改成實際的 API 呼叫)
        if userName == "demo" && password == "123456" {
            return .success
        } else {
            return .failure(.invalidCredentials)
        }
    }
}

// MARK: - Login Result
enum LoginResult {
    case success
    case failure(LoginError)
}

// MARK: - Login Error
enum LoginError: LocalizedError {
    case emptyUserName
    case emptyPassword
    case userNameTooShort
    case passwordTooShort
    case invalidCredentials
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .emptyUserName:
            return "請輸入使用者名稱"
        case .emptyPassword:
            return "請輸入密碼"
        case .userNameTooShort:
            return "使用者名稱至少需要 3 個字元"
        case .passwordTooShort:
            return "密碼至少需要 6 個字元"
        case .invalidCredentials:
            return "使用者名稱或密碼錯誤"
        case .networkError:
            return "網路連線錯誤，請稍後再試"
        }
    }
}
