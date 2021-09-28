//
//  UserListViewController.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/28.
//

import UIKit
import Combine

/// ユーザー一覧画面
class UserListViewController: UIViewController {

    // MARK: - Variables
    /// UserListPresenterInterface
    var presenter: UserListPresenterInterface!
    /// cancellables
    private var cancellables = [AnyCancellable]()

    // MARK: - Lifecycle Metohds
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        presenter.input?.viewDidLoadTrigger.send(())
    }
}

// MARK: - Priavte Methods
private extension UserListViewController {
    func bind() {
        presenter.output?.users
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("error: \(error)")
                }
            }, receiveValue: { value in
                print(value)
            })
            .store(in: &cancellables)
    }
}
