//
//  UserCell.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/29.
//

import UIKit

/// ユーザーセル
final class UserCell: UITableViewCell {

    // MARK: - Outlets
    /// ユーザー名ラベル
    @IBOutlet private weak var userNameLabel: UILabel!

    // MARK: - Public Methods
    /// セルを構築
    /// - Parameter user: User
    func configure(with user: User) {
        userNameLabel.text = user.loginName
    }
}
