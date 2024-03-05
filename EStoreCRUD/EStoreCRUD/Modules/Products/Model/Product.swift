//
//  Product.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 29/02/24.
//

import Foundation

struct Product: Codable, Identifiable {
    var id: Int
    var title: String
    var price: Double
    var description: String
    var images: [String]
    var category: Category
}

extension Product {
    static var dummy: [Product] = [
        Product(
            id: 26,
            title: "Sleek Mirror Finish Phone Case",
            price: 27,
            description: "Enhance your smartphone's look with this ultra-sleek mirror finish phone case. Designed to offer style with protection, the case features a reflective surface that adds a touch of elegance while keeping your device safe from scratches and impacts. Perfect for those who love a minimalist and modern aesthetic.",
            images: [
                "https://i.imgur.com/yb9UQKL.jpeg",
                "https://i.imgur.com/m2owtQG.jpeg",
                "https://i.imgur.com/bNiORct.jpeg"
            ],
            category: Category.dummy
        )
    ]
}
