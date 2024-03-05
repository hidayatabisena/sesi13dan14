//
//  ImageUtillity.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 06/03/24.
//

import Foundation

struct ImageUtility {
    static func extractImageUrl(from string: String) -> URL? {
        if let urlFromJsonArray = extractFirstUrlFromJsonString(string) {
            return urlFromJsonArray
        }
        
        return URL(string: string)
    }
    
    private static func extractFirstUrlFromJsonString(_ jsonString: String) -> URL? {
        guard let data = jsonString.data(using: .utf8),
              let imageUrlArray = try? JSONDecoder().decode([String].self, from: data),
              let firstUrlString = imageUrlArray.first,
              let firstUrl = URL(string: firstUrlString) else {
            return nil
        }
        
        return firstUrl
    }
}
