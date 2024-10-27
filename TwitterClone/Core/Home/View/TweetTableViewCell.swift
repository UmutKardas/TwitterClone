//
//  TweetTableViewCell.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 29.05.2024.
//
import Kingfisher
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

    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        return label
    }()

    private let tweetTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
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
        contentView.addSubview(displayNameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(tweetTextLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(replyButton)
        contentView.addSubview(retweetButton)
        contentView.addSubview(shareButton)
        configureConstraints()
        configureButtons()
    }

    func configure(with model: Tweet) {
        tweetTextLabel.text = model.content
        displayNameLabel.text = model.author.displayName
        usernameLabel.text = "@\(model.author.username)"
        avatarImageView.kf.setImage(with: URL(string: model.author.avatarData))
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),

            displayNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            displayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.trailingAnchor, constant: 5),
            usernameLabel.centerYAnchor.constraint(equalTo: displayNameLabel.centerYAnchor),

            tweetTextLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            tweetTextLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5),
            tweetTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            replyButton.leadingAnchor.constraint(equalTo: tweetTextLabel.leadingAnchor),
            replyButton.topAnchor.constraint(equalTo: tweetTextLabel.bottomAnchor, constant: 10),
            replyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            retweetButton.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor, constant: 30),
            retweetButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),

            likeButton.leadingAnchor.constraint(equalTo: retweetButton.trailingAnchor, constant: 30),
            likeButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),

            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 30),
            shareButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
        ])
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
