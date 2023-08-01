//
//  LocationView.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

final class LocationView: UIView {

    lazy private var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Воронеж"
        return label
    }()

    lazy private var pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pin")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(locationName: String) {
        self.init(frame: .zero)
        locationLabel.text = locationName
    }

    private func setupUI() {
        addSubview(pinImageView)
        addSubview(locationLabel)

        NSLayoutConstraint.activate([
            pinImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pinImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pinImageView.topAnchor.constraint(equalTo: topAnchor),

            locationLabel.leadingAnchor.constraint(equalTo: pinImageView.trailingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            locationLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
