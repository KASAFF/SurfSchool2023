//
//  ViewController.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

final class UserProfileViewController: UIViewController {


    private var isEditingSkills = false {
        didSet {
            switch isEditingSkills {
            case true:
                editButton.setImage(UIImage(named: "checkmark"), for: .normal)
            case false:
                editButton.setImage(UIImage(named: "editPen"), for: .normal)
            }
            collectionView.reloadData()
        }
    }

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

    lazy private var scrollView: UIScrollView = {
            let scroll = UIScrollView()
            scroll.translatesAutoresizingMaskIntoConstraints = false
            scroll.delegate = self
            scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
            return scroll
        }()

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
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "editPen"), for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
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

    lazy var collectionViewHeightAnchor = collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)


    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupUI()
    }

    @objc func editButtonTapped() {
        isEditingSkills.toggle()
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(userProfileView)
        scrollView.addSubview(skillsStackView)
        scrollView.addSubview(aboutMeView)
        scrollView.addSubview(collectionView)

        skillsStackView.translatesAutoresizingMaskIntoConstraints = false
        skillsStackView.distribution = .equalCentering

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            userProfileView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            userProfileView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45),
            userProfileView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -45),
            userProfileView.bottomAnchor.constraint(equalTo: scrollView.centerYAnchor)
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
            collectionViewHeightAnchor
        ])

        NSLayoutConstraint.activate([
            aboutMeView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            aboutMeView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            aboutMeView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])


            scrollView.alwaysBounceHorizontal = false
            scrollView.alwaysBounceVertical = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let contentHeight = aboutMeView.frame.maxY + 64
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: contentHeight)

        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeightAnchor.constant = height

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(SkillsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func calculateCellSize(with skillText: String, maxWidth: CGFloat) -> CGSize {
           let labelWidth = skillText.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 50
           var cellWidth = min(labelWidth, maxWidth)
           let cellHeight = skillText.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).height + 32

        cellWidth = min(cellWidth, view.frame.width - (isEditingSkills ? 100 : 50))

        if isEditingSkills {
            return CGSize(width: cellWidth + 50, height: cellHeight)
        } else {
            return CGSize(width: cellWidth, height: cellHeight)
        }
       }
}

extension UserProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let skillText = swiftDeveloperSkills[indexPath.item % swiftDeveloperSkills.count]
            let availableWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
            return calculateCellSize(with: skillText, maxWidth: availableWidth)
        }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        view.layoutIfNeeded()
    }
}



extension UserProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return swiftDeveloperSkills.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SkillsCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(with: swiftDeveloperSkills[indexPath.row], isEditing: isEditingSkills)
        return cell
    }
}

