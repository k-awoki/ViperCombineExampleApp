//
//  UserRepositroyListInteractor.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/29.
//

import Combine

/// UserRepositroyListInteractorUseCase
protocol UserRepositroyListInteractorUseCase: AnyObject {
    /// fetch
    func fetch() -> AnyPublisher<[Repository], Error>
}

/// UserRepositroyListInteractor
final class UserRepositroyListInteractor {
    /// APIリソース
    private let resource: GitHubRepositoriesApiResource
    /// initialize
    /// - Parameter loginName: ログイン名
    init(loginName: String) {
        resource = GitHubRepositoriesApiResource(loginName: loginName)
    }
}

// MARK: - UserRepositroyListInteractorUseCase
extension UserRepositroyListInteractor: UserRepositroyListInteractorUseCase {
    func fetch() -> AnyPublisher<[Repository], Error> {
        return Future<[Repository], Error> { [weak self] promise in
            guard let resource = self?.resource else {
                fatalError()
            }
            ApiClinet.request(resource, completion: { result in
                switch result {
                case .success(let response):
                    promise(.success(response))
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }
        .eraseToAnyPublisher()
    }
}
