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

/// Root Router
final class RootRouter: RootWireframe {

    /// UIWindow
    private let window: UIWindow
    
    /// initialize
    /// - Parameter window: UIWindow
    public init(window: UIWindow) {
        self.window = window
    }

    public func showRootScreen() {
        let rootViewController = UserListRouter.assembleModule()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
