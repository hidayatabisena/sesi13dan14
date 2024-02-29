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
            id: 180,
            title: "nike air jordans",
            price: 3000,
            description: "limited edition",
            images: ["https://placeimg.com/640/480/any", "https://i.imgur.com/qNOjJje.jpeg"],
            category: Category.dummy
        )
    ]
}
