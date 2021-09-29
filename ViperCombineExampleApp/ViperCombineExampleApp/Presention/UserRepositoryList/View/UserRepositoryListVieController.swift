//
//  UserRepositoryListVieController.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/29.
//

import UIKit
import Combine

/// ユーザーリポジトリ一覧画面
final class UserRepositoryListVieController: UIViewController {

    // MARK: - Variables

    /// UserRepositoryListPresenterInterface
    var presenter: UserRepositoryListPresenterInterface!
    /// リポジトリ一覧
    private var repositories: [Repository] = []
    /// cancellables
    private var cancellables = [AnyCancellable]()

    // MARK: - Outlets

    /// リポジトリ一覧TableView
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            let identifier = String(describing: RepositoryCell.self)
            let nib = UINib(nibName: identifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: identifier)
        }
    }

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        presenter.input?.viewDidLoadTrigger.send(())
    }
}

// MARK: - Priavte Methods
private extension UserRepositoryListVieController {
    /// bind
    func bind() {
        presenter.output?.repositories
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("error: \(error)")
                }
            }, receiveValue: { [weak self] value in
                self?.repositories = value
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDataSource
extension UserRepositoryListVieController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryCell else {
            return UITableViewCell()
        }
        cell.configure(with: repositories[indexPath.row])
        return cell
    }
}
