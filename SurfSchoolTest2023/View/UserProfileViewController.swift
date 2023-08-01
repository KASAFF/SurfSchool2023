//
//  ViewController.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

final class UserProfileViewController: UIViewController, UserProfileViewProtocol {

    var presenter: UserProfilePresenterProtocol

    private var isEditingSkills = false {
        didSet {
            switch isEditingSkills {
            case true:
                editButton.setImage(.checkmark, for: .normal)
                collectionView.performBatchUpdates {
                    collectionView.insertItems(at: [IndexPath(item: presenter.getCountOfItems(), section: 0)])
                    collectionView.reloadSections(IndexSet(integer: 0))
                }
            case false:
                editButton.setImage(.editPen, for: .normal)
                collectionView.performBatchUpdates {
                    collectionView.deleteItems(at: [IndexPath(item: presenter.getCountOfItems(), section: 0)])
                    collectionView.reloadSections(IndexSet(integer: 0))
                }
            }
            updateCollectionViewHeight()
            updateContentSizeScroll()
        }
    }

    init(presenter: UserProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    lazy private var backgroundGray: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .surfGray
        return backgroundView
    }()

    lazy private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        return scroll
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
        button.setImage(.editPen, for: .normal)
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

    lazy private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: SkillsCustomFlowLayout())

    lazy private var collectionViewHeightAnchor = collectionView.heightAnchor.constraint(equalToConstant: 200)


    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter.viewLoaded()
        setupCollectionView()
        setupUI()
    }

    @objc func editButtonTapped() {
        isEditingSkills.toggle()
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundGray)
        scrollView.addSubview(userProfileView)
        scrollView.addSubview(skillsStackView)
        scrollView.addSubview(aboutMeView)
        scrollView.addSubview(collectionView)

        skillsStackView.translatesAutoresizingMaskIntoConstraints = false
        skillsStackView.distribution = .equalCentering

        let backgroundBottomConstraint = backgroundGray.bottomAnchor.constraint(equalTo: scrollView.topAnchor)
        backgroundBottomConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            backgroundGray.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundGray.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundGray.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundBottomConstraint
        ])

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            userProfileView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            userProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userProfileView.bottomAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: -60)
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
            aboutMeView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            aboutMeView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            aboutMeView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])

        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
    }

    func updateCollectionViewWithDeletion(at indexPath: IndexPath) {
        self.collectionView.performBatchUpdates {
            self.collectionView.deleteItems(at: [indexPath])
        }

        updateCollectionViewHeight()
        updateContentSizeScroll()
    }

    func updateCollectionViewWithAdditing(at indexPath: IndexPath) {
        self.collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: [indexPath])
            self.collectionView.reloadData()
        }

        updateCollectionViewHeight()
        updateContentSizeScroll()
    }

    private func updateCollectionViewHeight() {
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeightAnchor.constant = height
    }

    private func updateContentSizeScroll() {
        let contentHeight = aboutMeView.frame.maxY + 64
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: contentHeight)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewHeight()
        updateContentSizeScroll()
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

    private func showAlertWithTextField() {
        let alert = UIAlertController(title: "Добавление навыка", message: "Введите название навыка, которым вы владеете", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "Введите название"
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self, weak alert] _ in
            if let textField = alert?.textFields?.first, let skillName = textField.text {
                self?.presenter.addSkill(with: skillName)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(addAction)

        present(alert, animated: true)
    }
}

extension UserProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let skillText: String
        if isEditingSkills && indexPath.item > presenter.getCountOfItems() - 1 {
            skillText = "+"
        } else {
            skillText = presenter.getTextOfSkill(of: indexPath.item)
        }
        let availableWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        return calculateCellSize(with: skillText, maxWidth: availableWidth)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        view.layoutIfNeeded()
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        view.layoutIfNeeded()
    }
}


extension UserProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEditingSkills {
            return presenter.getCountOfItems() + 1
        } else {
            return presenter.getCountOfItems()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SkillsCollectionViewCell else { return UICollectionViewCell() }

        if isEditingSkills && indexPath.item > presenter.getCountOfItems() - 1 {
            cell.configureCell(with: "+", isEditing: false)
            return cell
        }

        cell.configureCell(with: presenter.getTextOfSkill(of: indexPath.item), isEditing: isEditingSkills)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard isEditingSkills else { return }

        if indexPath.item > presenter.getCountOfItems() - 1 {
            showAlertWithTextField()
        } else {
            presenter.removeSkill(at: indexPath.item)
        }
    }
}

