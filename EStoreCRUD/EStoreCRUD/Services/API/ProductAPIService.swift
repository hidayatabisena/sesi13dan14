//
//  ProductAPIService.swift
//  EStoreCRUD
//
//  Created by Hidayat Abisena on 29/02/24.
//

import Foundation
import UIKit
import Alamofire

class ProductAPIService {
    static let shared = ProductAPIService()
    
    // private init() {}
    // MARK: - GET PRODUCT
    func fetchProductsByCategory(categoryId: Int) async throws -> [Product] {
        guard let url = Constant.Endpoint.productsByCategory(categoryId).fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        let data = try await NetworkService.shared.fetchData(from: url)
        
        let products = try JSONDecoder().decode([Product].self, from: data)
        
        return products
    }
}

// MARK: - CREATE PRODUCT
extension ProductAPIService {
    func createProduct(title: String, price: Double, description: String, categoryId: Int, images: [String]) async throws -> Product {
        guard let url = Constant.Endpoint.createProduct.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        print("We are accessing url \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newProductData = CreateProduct(title: title, price: price, description: description, categoryId: categoryId, images: images)
        
        request.httpBody = try JSONEncoder().encode(newProductData)
        print(String(data: request.httpBody!, encoding: .utf8) ?? "No body data")
        
        let data = try await NetworkService.shared.postData(with: request)
        let createdProduct = try JSONDecoder().decode(Product.self, from: data)
        
        return createdProduct
    }
}

// MARK: - UPLOAD IMAGE
//extension ProductAPIService {
//
//    func uploadImage(image: UIImage) async throws -> String {
//        guard let url = Constant.Endpoint.uploadFile.fullURLEndpoint() else {
//            throw URLError(.badURL)
//        }
//
//        let imageData = try convertImageToData(image)
//        let boundary = generateBoundary()
//        var request = createRequest(with: url, boundary: boundary)
//        let body = createRequestBody(with: imageData, boundary: boundary)
//
//        let responseData = try await performRequest(request: &request, body: body)
//        let uploadResponse = try decodeResponse(responseData)
//
//        return uploadResponse.location
//    }
//
//    private func convertImageToData(_ image: UIImage) throws -> Data {
//        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
//            throw NSError(domain: "image.convert.error", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image"])
//        }
//
//        return imageData
//    }
//
//    private func generateBoundary() -> String {
//        return "Boundary-\(UUID().uuidString)"
//    }
//
//    private func createRequest(with url: URL, boundary: String) -> URLRequest {
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        return request
//    }
//
//    private func createRequestBody(with imageData: Data, boundary: String) -> Data {
//        var body = Data()
//        body.append("--\(boundary)\r\n")
//        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n")
//        body.append("Content-Type: image/jpeg\r\n\r\n")
//        body.append(imageData)
//        body.append("\r\n")
//        body.append("--\(boundary)--\r\n")
//        return body
//    }
//
//    private func performRequest(request: inout URLRequest, body: Data) async throws -> Data {
//        request.httpBody = body
//        let (responseData, _) = try await URLSession.shared.upload(for: request, from: body)
//        return responseData
//    }
//
//    private func decodeResponse(_ data: Data) throws -> UploadResponse {
//        let decodedResponse = try JSONDecoder().decode(UploadResponse.self, from: data)
//        return decodedResponse
//    }
//}

// MARK: - UPLOAD IMAGE
extension ProductAPIService {
    func uploadImage(image: UIImage) async throws -> String {
        guard let url = Constant.Endpoint.uploadFile.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        // Pastikan image bisa di-convert ke Data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw ImageError.conversionFailed
        }
        
        // Menggunakan Alamofire untuk upload
        let data = try await withCheckedThrowingContinuation { continuation in
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }, to: url)
            .validate()
            .responseDecodable(of: UploadResponse.self) { response in
                switch response.result {
                case .success(let uploadResponse):
                    continuation.resume(returning: uploadResponse.location)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        
        return data
    }
}

// MARK: - DELETE PRODUCT
extension ProductAPIService {
    func deleteProduct(withId id: Int) async throws -> Bool {
        guard let url = Constant.Endpoint.deleteProduct(id).fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        let data = try await NetworkService.shared.postData(with: request)
        let results = try JSONDecoder().decode(Bool.self, from: data)
        
        return results
    }
}
