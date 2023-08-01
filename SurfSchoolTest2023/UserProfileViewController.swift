//
//  ViewController.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

final class UserProfileViewController: UIViewController {

    let swiftDeveloperSkills = [
        "Swift",
        "iOS",
        "UIKit",
        "SwiftUI",
        "Core Data",
        "Networking",
        "Keychain",
        "Auto Layout",
        "Git",
        "Debugging and testingDebugging and testingDebugging and testingDebugging and testing",
        "ARC"
    ]

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

    lazy private var skillsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Мои навыки"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    lazy private var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "editPen"), for: .normal)
        return button
    }()

    lazy private var skillsStackView = UIStackView(arrangedSubviews: [
        skillsLabel,
        editButton
    ])

    lazy private var aboutMeView: AboutMeView = {
        let view = AboutMeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: SkillsCustomFlowLayout())


    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(userProfileView)
        view.addSubview(skillsStackView)
        view.addSubview(aboutMeView)
        view.addSubview(collectionView)

        skillsStackView.translatesAutoresizingMaskIntoConstraints = false
        skillsStackView.distribution = .equalCentering

        NSLayoutConstraint.activate([
            userProfileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            userProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            userProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            userProfileView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            skillsStackView.topAnchor.constraint(equalTo: userProfileView.bottomAnchor, constant: 16),
            skillsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skillsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skillsStackView.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: skillsStackView.topAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            aboutMeView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            aboutMeView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            aboutMeView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)
        ])
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SkillsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false


    }

    private func calculateCellSize(with skillText: String, maxWidth: CGFloat) -> CGSize {
           let labelWidth = skillText.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 32
           let cellWidth = min(labelWidth, maxWidth)
           let cellHeight = skillText.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).height + 32

        if cellWidth >= view.frame.width - 32 {
            return CGSize(width: 100, height: cellHeight)
        }

           return CGSize(width: cellWidth, height: cellHeight)
       }
}

extension UserProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let skillText = swiftDeveloperSkills[indexPath.item % swiftDeveloperSkills.count]
            let availableWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
            return calculateCellSize(with: skillText, maxWidth: availableWidth)
        }
}



extension UserProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return swiftDeveloperSkills.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SkillsCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(with: swiftDeveloperSkills[indexPath.row])
        return cell
    }
}

