//
//  LoginViewController.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 23.06.2024.
//

import Combine
import UIKit

class LoginViewController: UIViewController {
    private var viewModel: LoginViewModel = .init()
    private var subscriptions = Set<AnyCancellable>()

    private let loginDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login to your account"
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

    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
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
        configureConstrains()
        bindView()
        setupTargets()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(loginDescriptionLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }

    private func setupTargets() {
        viewModel.successAction = { [weak self] in self?.presentNavigation(viewController: HomeViewController(), presentationStyle: .fullScreen) }
        emailTextField.addTarget(self, action: #selector(didChangeEmailTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordTextField), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }

    @objc private func didChangeEmailTextField() {
        viewModel.email = emailTextField.text
    }

    @objc private func didChangePasswordTextField() {
        viewModel.password = passwordTextField.text
    }

    @objc private func didTapLoginButton() {
        viewModel.loginUser()
        loginButton.isEnabled = false
    }

    private func bindView() {
        viewModel.$error.sink { [weak self] error in
            guard let error = error else { return }
            self?.presentAlert(title: "Error", message: error)
        }.store(in: &subscriptions)
    }

    private func configureConstrains() {
        NSLayoutConstraint.activate([
            loginDescriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            loginDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailTextField.centerXAnchor.constraint(equalTo: loginDescriptionLabel.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: loginDescriptionLabel.bottomAnchor, constant: 20),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 30),

            passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 30),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 150)

        ])
    }
}
