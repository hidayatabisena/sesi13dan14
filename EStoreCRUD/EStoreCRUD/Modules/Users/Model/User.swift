//
//  User.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 27/02/24.
//

import Foundation

struct User: Codable, Identifiable {
    var id: Int?
    var email, password, name: String
    var avatar: String
    var role: String?
}

extension User {
    static var dummy: User {
        User(
            id: 1,
            email: "temp@mailinator.id",
            password: "qwerty",
            name: "Temp User",
            avatar: "https://i.pravatar.cc/150?img=31", role: "customer"
        )
    }
}
