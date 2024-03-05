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
            return FailedMessages.unexpected
        }
    }
    
    private static func message(for urlError: URLError) -> String {
        switch urlError.code {
        case .notConnectedToInternet:
            return FailedMessages.notConnectedToInternet
        case .timedOut:
            return FailedMessages.timeout
        case .cannotParseResponse:
            return FailedMessages.cannotParseResponse
        default:
            return FailedMessages.unexpected
        }
    }
}

enum ImageError: Error {
    case conversionFailed
}

extension ImageError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .conversionFailed:
            return "Failed to convert image."
        }
    }
}

struct ServerErrorResponse: Codable {
    let message: String
    let statusCode: Int?
}
