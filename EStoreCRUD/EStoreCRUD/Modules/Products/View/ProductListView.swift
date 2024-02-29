//
//  ProductListView.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 29/02/24.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var productVM = ProductVM()
    let categoryId: Int
    
    var body: some View {
        NavigationStack {
            Group {
                if productVM.products.count == 0 {
                    ContentUnavailableView("No products yet", systemImage: "cart.badge.questionmark", description: Text("Try checking another products, or you can comeback later!!!"))
                } else {
                    List(productVM.products) { product in
                        ProductRowView(product: product)
                    }
                }
            }
            .navigationTitle("Products")
            .overlay {
                productVM.isLoading ? ProgressView() : nil
            }
            .task {
                await productVM.loadProducts(forCategory: categoryId)
            }
        }
    }
}

#Preview {
//    let vm = ProductVM()
//    vm.products = Product.dummy
    
    return ProductListView(categoryId: 2)
}
