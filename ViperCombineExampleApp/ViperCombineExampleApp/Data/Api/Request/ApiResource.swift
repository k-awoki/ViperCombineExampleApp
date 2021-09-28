//
//  ApiResource.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/28.
//

import Foundation

/// HTTP Method
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

/// API Resource
protocol ApiResource {
    associatedtype ResponseType: Codable
    /// ベースURL
    var baseUrl: URL { get }
    /// パス
    var path: String { get }
    /// HTTPメソッド
    var method: HttpMethod { get }
}

extension ApiResource {
    /// リクエスト
    func request() -> URLRequest {
        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
