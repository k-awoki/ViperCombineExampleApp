//
//  ApiClient.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/28.
//

import Foundation

/// API Client
final class ApiClinet {

    /// JSONデーコーダー
    private static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    /// APIリクエスト
    /// - Parameters:
    ///   - request: APIリソース
    ///   - completion: 完了ハンドラ
    static func request<T, V>(_ resource: T,
                              completion: @escaping ((Result<V, Error>) -> Void)) where T: ApiResource, T.ResponseType == V {
        let task = URLSession.shared.dataTask(with: resource.request(), completionHandler: { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let result = try jsonDecoder.decode(V.self, from: data)
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        })
        task.resume()
    }
}
