//
//  TweetFormViewController.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 3.08.2024.
//

import UIKit

class TweetFormViewController: UIViewController {
    private let viewModel = TweetFormViewModel()

    private let tweetTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 18)
        textView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        textView.layer.cornerRadius = 15
        textView.text = "What's happening?"
        textView.textColor = .darkGray
        return textView
    }()

    private let tweetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tweet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .label
        return button
    }()

    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 / 200"
        label.textColor = .darkGray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureConstraints()
        setupTargets()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUser()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        tweetTextView.delegate = self
        view.addSubview(tweetTextView)
        view.addSubview(tweetButton)
        view.addSubview(closeButton)
        view.addSubview(characterCountLabel)
    }

    private func setupTargets() {
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        tweetButton.addTarget(self, action: #selector(didTapTweetButton), for: .touchUpInside)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tweetTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tweetTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tweetTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tweetTextView.heightAnchor.constraint(equalToConstant: view.frame.height),

            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),

            tweetButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tweetButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tweetButton.widthAnchor.constraint(equalToConstant: 100),
            tweetButton.heightAnchor.constraint(equalToConstant: 40),

            characterCountLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            characterCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

        ])
    }

    @objc private func didTapCloseButton() {
        presentNavigation(viewController: HomeViewController(), presentationStyle: .fullScreen)
    }

    @objc private func didTapTweetButton() {
        viewModel.sendTweet { [weak self] in self?.presentNavigation(viewController: HomeViewController(), presentationStyle: .fullScreen) }
    }
}

extension TweetFormViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.text == "What's happening?" else { return }
        textView.text = ""
        textView.textColor = overrideUserInterfaceStyle == .dark ? .darkGray : .white
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.isEmpty else { return }
        textView.text = "What's happening?"
        textView.textColor = .darkGray
    }

    func textViewDidChange(_ textView: UITextView) {
        characterCountLabel.text = "\(textView.text.count) / 200 "
        viewModel.tweetText = textView.text
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let stringRange = Range(range, in: textView.text) else { return false }
        let updatedText = textView.text.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 200
    }
}
