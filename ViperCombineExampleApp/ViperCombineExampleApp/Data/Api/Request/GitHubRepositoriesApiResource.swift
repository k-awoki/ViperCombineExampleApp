//
//  GitHubRepositoriesApiResource.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/29.
//

import Foundation

/// GitHubRepositoriesApiResource
final class GitHubRepositoriesApiResource: ApiResource {
    typealias ResponseType = [Repository]
    /// ログイン名
    private let loginName: String
    var baseUrl: URL {
        guard let url = URL(string: "https://api.github.com") else {
            fatalError()
        }
        return url
    }
    var path: String {
        return String(format: "/users/%@/repos", loginName)
    }
    var method: HttpMethod {
        return .get
    }
    init(loginName: String) {
        self.loginName = loginName
    }
}
