//
//  TempProductRow.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 06/03/24.
//

import SwiftUI

struct TempProductRow: View {
    let product: Product
    
    var body: some View {
        HStack {
            Group {
                if let imageURLString = product.images.first,
                   let url = ImageUtility.extractImageUrl(from: imageURLString) {
                    tempAsyncImage(url: url)
                    
                } else {
                    Image(.fashion)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.headline)
                
                Text(product.description)
                    .font(.subheadline)
                    .lineLimit(2)
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
        }
    }
    
    @ViewBuilder
    private func tempAsyncImage(url: URL) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
            case .failure:
                Image(.fashion)
                    .resizable()
                
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 80, height: 80)
        .scaledToFill()
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    TempProductRow(product: Product.dummy[0])
}
