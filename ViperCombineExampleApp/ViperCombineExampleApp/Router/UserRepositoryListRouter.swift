//
//  UserRepositoryListRouter.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/29.
//

import UIKit

/// UserRepositoryListWireframe
protocol UserRepositoryListWireframe: AnyObject {
    static func assembleModule(loginName: String) -> UIViewController
}

/// UserRepositoryListRouter
final class UserRepositoryListRouter: UserRepositoryListWireframe {

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
    /// - Parameter loginName: ログイン名
    /// - Returns: UIViewController
    static func assembleModule(loginName: String) -> UIViewController {
        guard let viewController = UIStoryboard(name: String(describing: UserRepositoryListVieController.self),
                                                bundle: nil).instantiateInitialViewController() as? UserRepositoryListVieController else {
            fatalError()
        }
        let interactor = UserRepositoryListInteractor(loginName: loginName)
        let presenter = UserRepositoryListPresenter(interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
