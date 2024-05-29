//
//  TweetTableViewCell.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 29.05.2024.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    static let identifier: String = "TweetTableViewCell"

    weak var delegate: TweetTableViewCellDelegate?

    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.backgroundColor = .red
        image.layer.masksToBounds = true
        return image
    }()

    private let displayName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "Umut Kardas"
        return label
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 9, weight: .regular)
        label.text = "@umtkardas"
        label.textColor = .systemGray
        return label
    }()

    private let tweetTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "I am ios developer"
        return label
    }()

    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .gray
        return button
    }()

    private let retweetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.rectanglepath"), for: .normal)
        button.tintColor = .gray
        return button
    }()

    private let replyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .gray
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .gray
        return button
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayName)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(tweetTextLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(replyButton)
        contentView.addSubview(retweetButton)
        contentView.addSubview(shareButton)
        configureConstrains()
        configureButtons()
    }

    private func configureConstrains() {
        let avatarImageConstants = [
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50)
        ]

        let displayNameConstants = [
            displayName.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            displayName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ]

        let userNameConstants = [
            usernameLabel.leadingAnchor.constraint(equalTo: displayName.trailingAnchor, constant: 5),
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
        ]

        let tweetTextConstants = [
            tweetTextLabel.leadingAnchor.constraint(equalTo: displayName.leadingAnchor),
            tweetTextLabel.topAnchor.constraint(equalTo: displayName.bottomAnchor, constant: 10),
            tweetTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]

        let replyButtonConstants = [
            replyButton.leadingAnchor.constraint(equalTo: tweetTextLabel.leadingAnchor),
            replyButton.topAnchor.constraint(equalTo: tweetTextLabel.bottomAnchor, constant: 10),
            replyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]

        let retweetButtonConstants = [
            retweetButton.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor, constant: 50),
            retweetButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
        ]

        let likeButtonConstants = [
            likeButton.leadingAnchor.constraint(equalTo: retweetButton.trailingAnchor, constant: 50),
            likeButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
        ]

        let shareButtonConstants = [
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 50),
            shareButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
        ]

        NSLayoutConstraint.activate(avatarImageConstants)
        NSLayoutConstraint.activate(displayNameConstants)
        NSLayoutConstraint.activate(userNameConstants)
        NSLayoutConstraint.activate(tweetTextConstants)
        NSLayoutConstraint.activate(replyButtonConstants)
        NSLayoutConstraint.activate(retweetButtonConstants)
        NSLayoutConstraint.activate(likeButtonConstants)
        NSLayoutConstraint.activate(shareButtonConstants)
    }

    private func configureButtons() {
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        replyButton.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
        retweetButton.addTarget(self, action: #selector(didTapRetweet), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }

    @objc func didTapLike() {
        delegate?.tweettableViewCellDidTapLike()
    }

    @objc func didTapReply() {
        delegate?.tweettableViewCellDidTapReply()
    }

    @objc func didTapRetweet() {
        delegate?.tweettableViewCellDidTapRetweet()
    }

    @objc func didTapShare() {
        delegate?.tweettableViewCellDidTapShare()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError()
    }
}
