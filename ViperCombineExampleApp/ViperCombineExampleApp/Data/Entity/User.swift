//
//  User.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/28.
//

import Foundation

/// ユーザー
struct User: Codable {
    ///　ログイン名
    let loginName: String

    enum CodingKeys: String, CodingKey {
        case loginName = "login"
    }
}
