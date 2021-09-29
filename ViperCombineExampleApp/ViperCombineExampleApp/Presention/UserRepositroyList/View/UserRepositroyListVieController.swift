//
//  UserRepositroyListVieController.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/29.
//

import UIKit
import Combine

/// ユーザーリポジトリ一覧画面
final class UserRepositroyListVieController: UIViewController {

    // MARK: - Variables
    /// UserListPresenterInterface
    var presenter: UserListPresenterInterface!
    /// ユーザー一覧
    private var users: [User] = []
    /// cancellables
    private var cancellables = [AnyCancellable]()
}
