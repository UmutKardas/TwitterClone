//
//  RegisterViewController.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 23.06.2024.
//

import Combine
import UIKit

class RegisterViewController: UIViewController {
    private var viewModel: RegisterViewModel = .init()
    private var subscriptions = Set<AnyCancellable>()

    private let registerDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create your account"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        return label
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()

    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTargets()
        configureConstrains()
        bindViews()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(registerDescriptionLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(createAccountButton)
    }

    private func setupTargets() {
        viewModel.successAction = { [weak self] in self?.presentNavigation(viewController: HomeViewController(), presentationStyle: .fullScreen) }
        emailTextField.addTarget(self, action: #selector(didChangeEmailValue), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordValue), for: .editingChanged)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
    }

    @objc private func didTapCreateAccount() {
        viewModel.createUser()
        createAccountButton.isEnabled = false
    }

    @objc private func didChangeEmailValue() {
        viewModel.email = emailTextField.text
    }

    @objc private func didChangePasswordValue() {
        viewModel.password = passwordTextField.text
    }

    private func bindViews() {
        viewModel.$error.sink { [weak self] error in
            guard let error = error else { return }
            self?.presentAlert(title: "Error", message: error)
        }.store(in: &subscriptions)
    }

    private func configureConstrains() {
        NSLayoutConstraint.activate([
            registerDescriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            registerDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailTextField.centerXAnchor.constraint(equalTo: registerDescriptionLabel.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: registerDescriptionLabel.bottomAnchor, constant: 20),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 30),

            passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 30),

            createAccountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50),
            createAccountButton.widthAnchor.constraint(equalToConstant: 150)

        ])
    }
}
