//
//  UserListRouter.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/28.
//

import UIKit

/// UserListWireframe
protocol UserListWireframe: AnyObject {
    static func assembleModule() -> UIViewController
    func showRepositoryList(_ user: User)
}

/// UserListRouter
final class UserListRouter: UserListWireframe {

    // MARK: - Constants

    /// UIViewController
    private unowned let viewController: UIViewController

    // MARK: - Public Methods

    /// initialize
    /// - Parameter viewController: UIViewController
    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    /// ViewControllerを生成する
    /// - Returns: UIViewController
    static func assembleModule() -> UIViewController {
        guard let viewController = UIStoryboard(name: String(describing: UserListViewController.self),
                                                bundle: nil).instantiateInitialViewController() as? UserListViewController else {
            fatalError()
        }
        let interactor = UserListInteractor()
        let router = UserListRouter(viewController: viewController)
        let presenter = UserListPresenter(interactor: interactor,
                                          router: router)
        viewController.presenter = presenter
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }

    /// リポジトリ一覧画面へ遷移
    /// - Parameter user: User
    func showRepositoryList(_ user: User) {
        let userRpoesitoryListViewController = UserRepositoryListRouter.assembleModule(loginName: user.loginName)
        viewController.navigationController?.pushViewController(userRpoesitoryListViewController,
                                                                animated: true)
    }
}
