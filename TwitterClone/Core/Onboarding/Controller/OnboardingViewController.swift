//
//  OnboardingViewController.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 2.06.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "See what's happening in the world right now."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Create Account", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    private let loginDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Have an account already?"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.tintColor = .gray
        return label
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.tintColor = .systemBlue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureButtons()
        configureConstrains()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
        view.addSubview(createAccountButton)
        view.addSubview(loginDescriptionLabel)
        view.addSubview(loginButton)
    }

    private func configureButtons() {
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
    }

    @objc private func didTapCreateAccount() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }

    @objc private func didTapLogin() {
        let view = LoginViewController()
        navigationController?.pushViewController(view, animated: true)
    }

    private func configureConstrains() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            createAccountButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 60),

            loginDescriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            loginDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            loginButton.centerYAnchor.constraint(equalTo: loginDescriptionLabel.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: loginDescriptionLabel.trailingAnchor, constant: 5)
        ])
    }
}
