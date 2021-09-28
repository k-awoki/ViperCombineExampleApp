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
}

/// UserList Router
final class UserListRouter: UserListWireframe {

    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModule() -> UIViewController {
        guard let viewController = UIStoryboard(name: String(describing: UserListViewController.self),
                                                bundle: nil).instantiateInitialViewController() as? UserListViewController else {
            fatalError()
        }

        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
