//
//  SkillsCollectionViewCell.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

final class SkillsCollectionViewCell: UICollectionViewCell {

    lazy var skillLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with skillText: String) {
        skillLabel.text = skillText
    }

    private func setupUI() {
            layer.cornerRadius = 12
            backgroundColor = .surfGray
            addSubview(skillLabel)

            skillLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
            skillLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0).isActive = true
            skillLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
            skillLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0).isActive = true
        }
}
