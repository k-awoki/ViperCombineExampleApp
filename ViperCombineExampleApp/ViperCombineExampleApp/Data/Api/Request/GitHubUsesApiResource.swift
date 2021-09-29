//
//  GitHubUsesApiResource.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/29.
//

import Foundation

/// GitHubUsesApiResource
final class GitHubUsesApiResource: ApiResource {
    typealias ResponseType = [User]
    var baseUrl: URL {
        guard let url = URL(string: "https://api.github.com") else {
            fatalError()
        }
        return url
    }
    var path: String {
        return "/users"
    }
    var method: HttpMethod {
        return .get
    }
}
