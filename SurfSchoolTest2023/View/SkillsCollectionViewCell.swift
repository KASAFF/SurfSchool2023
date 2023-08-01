//
//  SkillsCollectionViewCell.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

final class SkillsCollectionViewCell: UICollectionViewCell {

    private var isEditingSkills = false

    lazy var skillLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    lazy private var deleteButton: UIImageView = {
        let imageView = UIImageView(image: .xmark)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    lazy private var stackView = UIStackView(arrangedSubviews: [
        skillLabel
    ])

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with skillText: String, isEditing: Bool) {
        skillLabel.text = skillText
        isEditingSkills = isEditing

        if isEditingSkills {
            stackView.addArrangedSubview(deleteButton)
        } else {
            deleteButton.removeFromSuperview()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.removeArrangedSubview(deleteButton)
    }

    private func setupUI() {
            layer.cornerRadius = 12
            backgroundColor = .surfGray

        stackView.spacing = 4

//        NSLayoutConstraint.activate([
//            deleteButton.heightAnchor.constraint(equalToConstant: 14),
//            deleteButton.widthAnchor.constraint(equalToConstant: 14)
//        ])

        deleteButton.setContentHuggingPriority(.required, for: .horizontal)
        deleteButton.setContentCompressionResistancePriority(.required, for: .horizontal)

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 17).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17).isActive = true
        }
}
