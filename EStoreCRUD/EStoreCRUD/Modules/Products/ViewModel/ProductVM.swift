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
    
    func loadProducts(forCategory categoryId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedProducts = try await ProductAPIService.shared.fetchProductsByCategory(categoryId: categoryId)
            self.products = fetchedProducts
        } catch {
            print(error)
            self.errorMessage = "Failed to fetch products: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
