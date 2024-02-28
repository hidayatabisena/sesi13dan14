//
//  AuthService.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 27/02/24.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    func createUser(with user: User) async throws -> User {
        guard let url = Constant.fullEndpoint() else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(user)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.init(rawValue: httpResponse.statusCode))
        }
        
        let results = try JSONDecoder().decode(User.self, from: data)
        
        return results
    }
}
