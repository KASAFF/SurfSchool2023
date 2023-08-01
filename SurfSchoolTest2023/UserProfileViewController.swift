//
//  ViewController.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

final class UserProfileViewController: UIViewController {

    lazy private var upperBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .surfGray
        return view
    }()

    lazy private var userProfileView: UserProfileView = {
        let userProfileVIew = UserProfileView()
        userProfileVIew.translatesAutoresizingMaskIntoConstraints = false
        return userProfileVIew
    }()



    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surfGray

        setupUI()
    }

    private func setupUI() {
        view.addSubview(userProfileView)

        NSLayoutConstraint.activate([
            userProfileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            userProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            userProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            userProfileView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

