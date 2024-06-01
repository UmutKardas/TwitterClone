//
//  ProfileTableViewHeader.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 1.06.2024.
//

import UIKit

class ProfileTableViewHeader: UIView {
    private let tabs: [UIButton] = ["Tweets", "Tweets & Replies", "Media", "Likes"]
        .map { buttonTitle in
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            button.tintColor = .secondaryLabel
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }

    private lazy var sectionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: tabs)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .yellow
        image.contentMode = .scaleAspectFill
        return image
    }()

    private let avatarImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()

    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25)
        label.text = "Umut Kardas"
        return label
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        label.text = "@umtkardas"
        return label
    }()

    private let biographyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.text = "I am iOS developer."
        return label
    }()

    private let joinDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        return imageView
    }()

    private let joinDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Joined April 2024"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()

    private let followerCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "300"
        label.textColor = .label
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()

    private let followerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fallower"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let followingCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "100"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    private let followingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fallowing"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImage)
        addSubview(avatarImage)
        addSubview(displayNameLabel)
        addSubview(usernameLabel)
        addSubview(biographyLabel)
        addSubview(joinDateLabel)
        addSubview(joinDateImageView)
        addSubview(followerLabel)
        addSubview(followerCountLabel)
        addSubview(followingLabel)
        addSubview(followingCountLabel)
        addSubview(sectionStack)
        configureConstraints()
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImage.topAnchor.constraint(equalTo: topAnchor),
            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 150),

            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            avatarImage.centerYAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            avatarImage.heightAnchor.constraint(equalToConstant: 80),

            displayNameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15),
            displayNameLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),

            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5),

            biographyLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            biographyLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),

            joinDateImageView.leadingAnchor.constraint(equalTo: biographyLabel.leadingAnchor),
            joinDateImageView.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: 5),

            joinDateLabel.leadingAnchor.constraint(equalTo: joinDateImageView.trailingAnchor, constant: 5),
            joinDateLabel.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: 5),

            followingCountLabel.leadingAnchor.constraint(equalTo: joinDateImageView.leadingAnchor),
            followingCountLabel.topAnchor.constraint(equalTo: joinDateImageView.bottomAnchor, constant: 8),

            followingLabel.leadingAnchor.constraint(equalTo: followingCountLabel.trailingAnchor, constant: 3),
            followingLabel.centerYAnchor.constraint(equalTo: followingCountLabel.centerYAnchor),

            followerCountLabel.leadingAnchor.constraint(equalTo: followingLabel.trailingAnchor, constant: 10),
            followerCountLabel.centerYAnchor.constraint(equalTo: followingLabel.centerYAnchor),

            followerLabel.leadingAnchor.constraint(equalTo: followerCountLabel.trailingAnchor, constant: 3),
            followerLabel.centerYAnchor.constraint(equalTo: followerCountLabel.centerYAnchor),

            sectionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            sectionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            sectionStack.topAnchor.constraint(equalTo: followingCountLabel.bottomAnchor, constant: 5),
            sectionStack.heightAnchor.constraint(equalToConstant: 35)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
