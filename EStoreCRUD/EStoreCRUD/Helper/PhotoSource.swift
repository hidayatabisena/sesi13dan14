//
//  PhotoSource.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 29/02/24.
//

import Foundation

enum PhotoSource: Identifiable {
    case photoLibrary
    case camera
    
    var id: Int {
        hashValue
    }
    
//    var id: String {
//        switch self {
//        case .photoLibrary:
//            return "photoLibrary"
//        case .camera:
//            return "camera"
//        }
//    }
}
