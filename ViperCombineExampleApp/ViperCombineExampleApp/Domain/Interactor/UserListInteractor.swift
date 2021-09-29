//
//  UserListInteractor.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/28.
//

import Combine

/// UserListInteractorUseCase
protocol UserListInteractorUseCase: AnyObject {
    /// fetch
    func fetch() -> AnyPublisher<[User], Error>
}

/// UserListInteractor
final class UserListInteractor {

    // MARK: - Constants

    /// APIリソース
    private let resource = GitHubUsesApiResource()
}

// MARK: - UserListInteractorUseCase
extension UserListInteractor: UserListInteractorUseCase {
    func fetch() -> AnyPublisher<[User], Error> {
        return Future<[User], Error> { [weak self] promise in
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
