//
//  ProductAPIService.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 29/02/24.
//

import Foundation

class ProductAPIService {
    static let shared = ProductAPIService()
    private init() {}
    
    func fetchProductsByCategory(categoryId: Int) async throws -> [Product] {
        guard let url = Constant.Endpoint.productsByCategory(categoryId).fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        let data = try await NetworkService.shared.fetchData(from: url)
        
        let products = try JSONDecoder().decode([Product].self, from: data)
        
        return products
    }
}
