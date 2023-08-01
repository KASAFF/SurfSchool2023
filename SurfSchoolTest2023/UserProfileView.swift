//
//  UserProfileView.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

final class UserProfileView: UIView {

    lazy private var moduleTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "Профиль"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    lazy private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "man")
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy private var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Иванов Иван Иванович"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 5
        return label
    }()

    lazy private var userBioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Middle iOS-разработчик, опыт более 2-х лет"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    lazy private var locationView: UIView = {
        let locationView = LocationView()
        locationView.translatesAutoresizingMaskIntoConstraints = false
        return locationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }

    private func setupUI() {
        backgroundColor = .surfGray

        addSubview(moduleTitleLabel)
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        addSubview(userBioLabel)
        addSubview(locationView)

        NSLayoutConstraint.activate([
            moduleTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            moduleTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: moduleTitleLabel.bottomAnchor, constant: 42),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120)
        ])

        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            userNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            userNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            userBioLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            userBioLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            userBioLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4)
        ])

        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 2),
            locationView.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            locationView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

    }
}
