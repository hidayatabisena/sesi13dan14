//
//  Constant.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 27/02/24.
//

import Foundation

struct Constant {
    static let baseURL = "https://api.escuelajs.co/api/"
    static let apiVersion = "v1"
    // static let endpoint = "users"
    
//    static func fullEndpoint() -> URL? {
//        let fullURLString = URL(string: "\(baseURL)\(apiVersion)/\(endpoint)")
//        return fullURLString
//    }
    
    enum Endpoint {
        case users
        case productsByCategory(Int)
        case createProduct
        case uploadFile
        case deleteProduct(Int)
        case login
        
        func path() -> String {
            switch self {
            case .users:
                return "users"
            case .productsByCategory(let categoryId):
                return "categories/\(categoryId)/products"
            case .createProduct:
                return "products"
            case .uploadFile:
                return "files/upload"
            case .deleteProduct(let productId):
                return "products/\(productId)"
            case .login:
                return "auth/login"
            }
        }
        
        func fullURLEndpoint() -> URL? {
            let fullURL = URL(string: "\(baseURL)\(apiVersion)/\(self.path())")
            
            return fullURL
        }
    }
    
    static let registerView = "Registration"
    static let usersList = "List of User"
}

enum FailedMessages {
    static let notConnectedToInternet = "The internet connection appears to be offline. Please try again later."
    static let timeout = "The network request timed out. Please check your connection and try again."
    static let unexpected = "An unexpected network error occurred. Please try again."
    static let cannotParseResponse = "The data cannot be parsed to the expected format. Please check your input form."
}
