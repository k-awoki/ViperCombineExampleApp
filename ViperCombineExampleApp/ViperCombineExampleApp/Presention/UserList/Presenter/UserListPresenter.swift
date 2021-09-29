//
//  UserListPresenter.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/29.
//

import Foundation
import Combine

/// UserListPresenterInput
protocol UserListPresenterInput: AnyObject {
    /// ViewDidLoad
    var viewDidLoadTrigger: PassthroughSubject<Void, Never> { get }
    /// didSelectRowAt
    var didSelectUserTrigger: PassthroughSubject<User, Never> { get }
}

/// UserListPresenterOutput
protocol UserListPresenterOutput: AnyObject {
    /// ユーザー情報
    var users: CurrentValueSubject<[User], Error> { get }
}

/// UserListPresenterInterface
protocol UserListPresenterInterface {
    /// UserListPresenterInput
    var input: UserListPresenterInput? { get }
    /// UserListPresenterOutput
    var output: UserListPresenterOutput? { get }
}

/// UserListPresenter
final class UserListPresenter: UserListPresenterInterface, UserListPresenterInput, UserListPresenterOutput {

    // MARK: - Inputs

    var viewDidLoadTrigger = PassthroughSubject<Void, Never>()
    var didSelectUserTrigger = PassthroughSubject<User, Never>()

    // MARK: - Outputs

    var users = CurrentValueSubject<[User], Error>([])

    // MARK: - Constants

    /// Interactor
    private let interactor: UserListInteractorUseCase
    /// Router
    private let router: UserListWireframe

    // MARK: - Variables

    /// UserListPresenterInput
    weak var input: UserListPresenterInput? { return self }
    /// UserListPresenterOutput
    weak var output: UserListPresenterOutput? { return self }
    /// cancellables
    private var cancellables = [AnyCancellable]()

    // MARK: - Public Methods

    /// initialize
    /// - Parameters:
    ///   - interactor: UserListInteractorUseCase
    ///   - router: UserListWireframe
    init(interactor: UserListInteractorUseCase,
         router: UserListWireframe) {
        self.interactor = interactor
        self.router = router
        bind()
    }
}

// MARK: - Private Methods
private extension UserListPresenter {
    /// Bind
    private func bind() {
        viewDidLoadTrigger
            .compactMap({ [weak self] in self?.interactor.fetch() })
            .flatMap({ $0 })
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.users.send(completion: .failure(error))
                }
            }, receiveValue: { [weak self] value in
                self?.users.send(value)
            })
            .store(in: &cancellables)

        didSelectUserTrigger
            .sink(receiveValue: { [weak self] user in
                self?.router.showRepositoryList(user)
            })
            .store(in: &cancellables)
    }
}
