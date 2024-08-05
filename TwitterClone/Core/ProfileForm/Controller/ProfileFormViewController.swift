//
//  ProfileFormViewController.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 27.07.2024.
//

import Combine
import PhotosUI
import UIKit

class ProfileFormViewController: UIViewController {
    private let viewModel = ProfileFormViewModel()

    private let titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Fill in your data"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        return label
    }()

    private let avatarImage = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 60
        image.clipsToBounds = true
        image.image = UIImage(systemName: "camera.fill")
        image.isUserInteractionEnabled = true
        image.backgroundColor = .lightGray
        return image
    }()

    private let displayTextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.backgroundColor = .secondarySystemFill
        textField.textAlignment = .left
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 20
        textField.attributedPlaceholder = NSAttributedString(string: "Display Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()

    private let usernameTextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.backgroundColor = .secondarySystemFill
        textField.textAlignment = .left
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 20
        textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()

    private let biographyTextField = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .secondarySystemFill
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 20
        textView.textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        textView.attributedText = NSAttributedString(string: "Tell the world about yourself", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textView.textColor = .gray
        textView.font = .systemFont(ofSize: 16)
        return textView
    }()

    private let submitButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()

    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        biographyTextField.delegate = self
        setupView()
        configureConstrains()
        setupTargets()
        bindView()
    }

    private func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(avatarImage)
        view.addSubview(displayTextField)
        view.addSubview(usernameTextField)
        view.addSubview(biographyTextField)
        view.addSubview(submitButton)
    }

    private func configureConstrains() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),

            avatarImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            avatarImage.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: 120),
            avatarImage.widthAnchor.constraint(equalToConstant: 120),

            displayTextField.centerXAnchor.constraint(equalTo: avatarImage.centerXAnchor),
            displayTextField.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 30),
            displayTextField.heightAnchor.constraint(equalToConstant: 50),
            displayTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            displayTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            usernameTextField.centerXAnchor.constraint(equalTo: displayTextField.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: displayTextField.bottomAnchor, constant: 30),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: displayTextField.trailingAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: displayTextField.leadingAnchor),

            biographyTextField.centerXAnchor.constraint(equalTo: usernameTextField.centerXAnchor),
            biographyTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            biographyTextField.heightAnchor.constraint(equalToConstant: 150),
            biographyTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            biographyTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),

            submitButton.leadingAnchor.constraint(equalTo: biographyTextField.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: biographyTextField.trailingAnchor),
            submitButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupTargets() {
        avatarImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToUploadImage)))
        displayTextField.addTarget(self, action: #selector(didUpdateDisplayTextField), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(didUpdateUsernameTextField), for: .editingChanged)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        viewModel.successAction = { [weak self] in self?.presentNavigation(viewController: HomeViewController(), presentationStyle: .fullScreen) }
    }

    private func bindView() {
        viewModel.$error.sink { [weak self] error in
            guard let error = error else { return }
            self?.presentAlert(title: "Error", message: error)
        }.store(in: &subscriptions)
    }

    @objc private func didTapToUploadImage() {
        var configuration = PHPickerConfiguration()
        configuration.mode = .default
        configuration.selectionLimit = 1

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }

    @objc private func didUpdateDisplayTextField() {
        viewModel.displayName = displayTextField.text
    }

    @objc private func didUpdateUsernameTextField() {
        viewModel.username = usernameTextField.text
    }

    @objc private func submit() {
        viewModel.submit()
    }
}

extension ProfileFormViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if biographyTextField != biographyTextField { return }
        viewModel.biography = biographyTextField.text
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        guard biographyTextField.text == "What's happening?" else { return }
        biographyTextField.text = ""
        biographyTextField.textColor = .black
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard biographyTextField.text.isEmpty else { return }
        biographyTextField.text = "What's happening?"
        biographyTextField.textColor = .lightGray
    }
}

extension ProfileFormViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                guard let image = image as? UIImage else { return }
                DispatchQueue.main.async {
                    self?.avatarImage.image = image
                    self?.viewModel.imageData = image
                }
            }
        }
    }
}
