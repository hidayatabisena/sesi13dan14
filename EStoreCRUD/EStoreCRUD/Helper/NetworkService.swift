//
//  NetworkService.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 29/02/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum NetworkError: Error {
    case badURLResponse(url: URL)
    case unknown(HTTPURLResponse?)
    case unauthorized(message: String, statusCode: Int)
}

// handle error 401
class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    // MARK: - POST
    func postData(with request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badURLResponse(url: request.url!)
        }
        
        if httpResponse.statusCode == 401, let responseBody = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) {
            // Jika status code adalah 401 (Unauthorized), lempar error unauthorized dengan pesan dari server
            throw NetworkError.unauthorized(message: responseBody.message, statusCode: httpResponse.statusCode)
        } else if !(200...299).contains(httpResponse.statusCode) {
            // Untuk status code selain 200-299, lempar error unknown
            throw NetworkError.unknown(httpResponse)
        }
        
        return data
    }
    
    // MARK: - GET
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badURLResponse(url: url)
        }
        
        if httpResponse.statusCode == 401, let responseBody = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) {
            throw NetworkError.unauthorized(message: responseBody.message, statusCode: httpResponse.statusCode)
        } else if !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.unknown(httpResponse)
        }
        
        return data
    }
}
