//
//  RootRouter.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/28.
//

import UIKit

/// RootWireframe
protocol RootWireframe: AnyObject {
    func showRootScreen()
}

/// RootRouter
final class RootRouter: RootWireframe {

    // MARK: - Constants

    /// UIWindow
    private let window: UIWindow

    // MARK: - Public Methods

    /// initialize
    /// - Parameter window: UIWindow
    public init(window: UIWindow) {
        self.window = window
    }

    /// ルート画面を表示
    public func showRootScreen() {
        let rootViewController = UserListRouter.assembleModule()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
