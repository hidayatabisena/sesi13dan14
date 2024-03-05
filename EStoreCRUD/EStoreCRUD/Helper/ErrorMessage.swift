//
//  ErrorMessage.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 27/02/24.
//

import Foundation

struct ErrorMessage {
    static func message(for error: Error) -> String {
        switch error {
        case let urlError as URLError:
            return message(for: urlError)
        default:
            return FailedMessage.unexpected
        }
    }
    
    private static func message(for urlError: URLError) -> String {
        switch urlError.code {
        case .notConnectedToInternet:
            return FailedMessage.notConnectedToInternet
            
        case .timedOut:
            return FailedMessage.timeout
            
        default:
            return FailedMessage.unexpected
        }
    }
}

enum ImageError: Error {
    case conversionFailed
    case fileNotSupported
}

extension ImageError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .conversionFailed:
            return "Failed to convert image."
        case .fileNotSupported:
            return "File doesn't support"
        }
    }
}
