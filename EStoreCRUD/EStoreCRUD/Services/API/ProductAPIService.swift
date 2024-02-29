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
    
    // MARK: - FETCH PRODUCT
    func fetchProductsByCategory(categoryId: Int) async throws -> [Product] {
        guard let url = Constant.Endpoint.productsByCategory(categoryId).fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        let data = try await NetworkService.shared.fetchData(from: url)
        
        let products = try JSONDecoder().decode([Product].self, from: data)
        
        return products
    }
    
    
}

// MARK: - CREATE PRODUCT
extension ProductAPIService {
    func createProduct(title: String, price: Double, description: String, categoryId: Int, images: [String]) async throws -> Product {
        
        guard let url = Constant.Endpoint.createProduct.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newProductData = CreateProduct(title: title, price: price, description: description, categoryId: categoryId, images: images)
        
        request.httpBody = try JSONEncoder().encode(newProductData)
        
        let data = try await NetworkService.shared.postData(with: request)
        
        let createdProduct = try JSONDecoder().decode(Product.self, from: data)
        
        return createdProduct
    }
}
