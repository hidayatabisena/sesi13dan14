//
//  UploadResponse.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 05/03/24.
//

import Foundation

struct UploadResponse: Codable {
    let originalName: String
    let filename: String
    let location: String
}
