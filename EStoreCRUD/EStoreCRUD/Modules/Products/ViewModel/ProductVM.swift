//
//  ProductVM.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 29/02/24.
//

import Foundation

@MainActor
class ProductVM: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - LOAD PRODUCTS
    func loadProducts(forCategory categoryId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedProducts = try await ProductAPIService.shared.fetchProductsByCategory(categoryId: categoryId)
            self.products = fetchedProducts.reversed()
        } catch {
            print(error)
            self.errorMessage = "Failed to fetch products: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}

// MARK: - ADD PRODUCT
extension ProductVM {
    func addProduct(title: String, price: Double, description: String, categoryId: Int, images: [String]) async {
        isLoading = true
        
        do {
            let createdProduct = try await ProductAPIService.shared.createProduct(title: title, price: price, description: description, categoryId: categoryId, images: images)
            
            products.append(createdProduct)
            print(createdProduct)
        } catch {
            errorMessage = "Failed to create product: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
