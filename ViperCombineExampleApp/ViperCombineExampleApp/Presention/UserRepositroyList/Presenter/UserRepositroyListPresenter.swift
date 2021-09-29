//
//  UserRepositroyListPresenter.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/29.
//

import Combine

/// UserRepositroyListPresenterInput
protocol UserRepositroyListPresenterInput: AnyObject {
    /// ViewDidLoad
    var viewDidLoadTrigger: PassthroughSubject<Void, Never> { get }
}

/// UserRepositroyListPresenterOutput
protocol UserRepositroyListPresenterOutput: AnyObject {
    /// リポジトリ情報
    var repositories: CurrentValueSubject<[Repository], Error> { get }
}

/// UserRepositroyListPresenterInterface
protocol UserRepositroyListPresenterInterface {
    /// UserRepositroyListPresenterInput
    var input: UserRepositroyListPresenterInput? { get }
    /// UserRepositroyListPresenterOutput
    var output: UserRepositroyListPresenterOutput? { get }
}

/// UserRepositroyListPresenter
final class UserRepositroyListPresenter: UserRepositroyListPresenterInterface, UserRepositroyListPresenterInput, UserRepositroyListPresenterOutput {

    // MARK: - Inputs
    var viewDidLoadTrigger = PassthroughSubject<Void, Never>()

    // MARK: - Outputs
    var repositories = CurrentValueSubject<[Repository], Error>([])

    // MARK: - Constants
    /// interactor
    private let interactor: UserRepositroyListInteractorUseCase

    // MARK: - Variables
    /// UserRepositroyListPresenterInput
    weak var input: UserRepositroyListPresenterInput? { return self }
    /// UserRepositroyListPresenterOutput
    weak var output: UserRepositroyListPresenterOutput? { return self }
    /// cancellables
    private var cancellables = [AnyCancellable]()

    // MARK: - Public Methods
    /// initialize
    /// - Parameter interactor: UserRepositroyListInteractorUseCase
    init(interactor: UserRepositroyListInteractorUseCase) {
        self.interactor = interactor
        bind()
    }
}

// MARK: - Private Methods
private extension UserRepositroyListPresenter {
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
