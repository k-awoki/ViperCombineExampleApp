//
//  UserRepositoryListPresenter.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/29.
//

import Combine

/// UserRepositoryListPresenterInput
protocol UserRepositoryListPresenterInput: AnyObject {
    /// ViewDidLoad
    var viewDidLoadTrigger: PassthroughSubject<Void, Never> { get }
}

/// UserRepositoryListPresenterOutput
protocol UserRepositoryListPresenterOutput: AnyObject {
    /// リポジトリ情報
    var repositories: CurrentValueSubject<[Repository], Error> { get }
}

/// UserRepositoryListPresenterInterface
protocol UserRepositoryListPresenterInterface {
    /// UserRepositoryListPresenterInput
    var input: UserRepositoryListPresenterInput? { get }
    /// UserRepositoryListPresenterOutput
    var output: UserRepositoryListPresenterOutput? { get }
}

/// UserRepositoryListPresenter
final class UserRepositoryListPresenter: UserRepositoryListPresenterInterface, UserRepositoryListPresenterInput, UserRepositoryListPresenterOutput {

    // MARK: - Inputs

    var viewDidLoadTrigger = PassthroughSubject<Void, Never>()

    // MARK: - Outputs

    var repositories = CurrentValueSubject<[Repository], Error>([])

    // MARK: - Constants

    /// interactor
    private let interactor: UserRepositoryListInteractorUseCase

    // MARK: - Variables

    /// UserRepositoryListPresenterInput
    weak var input: UserRepositoryListPresenterInput? { return self }
    /// UserRepositoryListPresenterOutput
    weak var output: UserRepositoryListPresenterOutput? { return self }
    /// cancellables
    private var cancellables = [AnyCancellable]()

    // MARK: - Public Methods

    /// initialize
    /// - Parameter interactor: UserRepositoryListInteractorUseCase
    init(interactor: UserRepositoryListInteractorUseCase) {
        self.interactor = interactor
        bind()
    }
}

// MARK: - Private Methods
private extension UserRepositoryListPresenter {
    /// Bind
    private func bind() {
        viewDidLoadTrigger
            .compactMap({ [weak self] in self?.interactor.fetch() })
            .flatMap({ $0 })
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.repositories.send(completion: .failure(error))
                }
            }, receiveValue: { [weak self] value in
                self?.repositories.send(value)
            })
            .store(in: &cancellables)
    }
}
