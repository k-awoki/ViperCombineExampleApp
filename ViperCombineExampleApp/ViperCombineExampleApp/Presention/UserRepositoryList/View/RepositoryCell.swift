//
//  RepositoryCell.swift
//  ViperCombineExampleApp
//
//  Created by 青木孝乃輔 on 2021/09/29.
//

import UIKit

/// リポジトリセル
final class RepositoryCell: UITableViewCell {
    // MARK: - Outlets

    /// リポジトリ名ラベル
    @IBOutlet private weak var repositoryNameLabel: UILabel!

    // MARK: - Public Methods

    /// セルを構築
    /// - Parameter repository: Repository
    func configure(with repository: Repository) {
        repositoryNameLabel.text = repository.name
    }
}
