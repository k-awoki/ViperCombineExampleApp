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
    /// ユーザー一覧
    private var users: [User] = []
    /// cancellables
    private var cancellables = [AnyCancellable]()

    // MARK: - Outlets
    /// ユーザー一覧TableView
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            let identifier = String(describing: UserCell.self)
            let nib = UINib(nibName: identifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: identifier)
        }
    }

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
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("error: \(error)")
                }
            }, receiveValue: { [weak self] value in
                self?.users = value
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        cell.configure(with: users[indexPath.row])
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
}
