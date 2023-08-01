//
//  AboutMeView.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

final class AboutMeView: UIView {
    lazy var aboutMeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "О себе"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    lazy var bioTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Experienced software engineer skilled in developing scalable and maintainable systems"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(aboutMeLabel)
        addSubview(bioTextLabel)

        NSLayoutConstraint.activate([
            aboutMeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            aboutMeLabel.topAnchor.constraint(equalTo: topAnchor),
            aboutMeLabel.heightAnchor.constraint(equalToConstant: 12),

            bioTextLabel.leadingAnchor.constraint(equalTo: aboutMeLabel.leadingAnchor),
            bioTextLabel.topAnchor.constraint(equalTo: aboutMeLabel.topAnchor, constant: 24),
            bioTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bioTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
