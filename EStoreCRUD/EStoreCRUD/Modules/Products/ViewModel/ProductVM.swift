//
//  ProductVM.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 29/02/24.
//

import Foundation
import UIKit

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

// MARK: - ADD PRODUCT WITH IMAGE
extension ProductVM {
    func addProductWithImage(title: String, price: Double, description: String, categoryId: Int, image: UIImage) async {
        // Langkah 1: Mengunggah gambar
        guard let imageUrl = await uploadImage(image: image) else {
            // Handle jika imageUrl nil, misalnya dengan menampilkan pesan error.
            self.errorMessage = ErrorMessage.message(for: ImageError.conversionFailed)
            return
        }
        
        // Langkah 2: Menambahkan produk dengan URL gambar
        // Karena uploadImage sudah menghandle error-nya sendiri dan tidak melempar error,
        // tidak perlu menggunakan try-catch di sini.
        await addProduct(title: title, price: price, description: description, categoryId: categoryId, images: [imageUrl])
    }
}

// MARK: - UPLOAD IMAGE
extension ProductVM {
    func uploadImage(image: UIImage) async -> String? {
        isLoading = true
        
        do {
            let imageUrl = try await ProductAPIService.shared.uploadImage(image: image)
            self.isLoading = false
            return imageUrl // URL berhasil di-upload dan diinisialisasi
        } catch {
            self.errorMessage = ErrorMessage.message(for: error)
            self.isLoading = false
            return nil // Mengembalikan nil jika terjadi error
        }
    }
}
