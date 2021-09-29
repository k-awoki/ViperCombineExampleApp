//
//  Repository.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/29.
//

import Foundation

/// リポジトリ
struct Repository: Codable {
    /// リポジトリ名
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}
