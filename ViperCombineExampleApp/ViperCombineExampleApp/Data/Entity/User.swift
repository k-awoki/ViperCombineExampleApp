//
//  User.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/28.
//

import Foundation

struct User: Codable {
    let loginName: String
    let followers: Int
    let following: Int

    enum CodingKeys: String, CodingKey {
        case loginName = "login"
        case followers
        case following
    }
}
