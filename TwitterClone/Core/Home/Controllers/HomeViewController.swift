//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 29.05.2024.
//

import Combine
import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()
    var subscriptions = Set<AnyCancellable>()

    private let timelineTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()

    private let tweetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .label
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureConstrains()
        configureNavigationBar()
        handleAuthentication()
        setupTargets()
        bindViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUser()
    }

    private func setupView() {
        timelineTableView.frame = view.frame
        view.addSubview(timelineTableView)
        view.addSubview(tweetButton)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
    }

    private func configureConstrains() {
        NSLayoutConstraint.activate([
            tweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tweetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tweetButton.widthAnchor.constraint(equalToConstant: 60),
            tweetButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func setupTargets() {
        tweetButton.addTarget(self, action: #selector(didTapTweet), for: .touchUpInside)
    }

    private func handleAuthentication() {
        if Auth.auth().currentUser != nil { return }
        presentNavigation(viewController: OnboardingViewController(), presentationStyle: .fullScreen)
    }

    private func handleOnboardingForm() {
        presentNavigation(viewController: ProfileFormViewController(), presentationStyle: .fullScreen)
    }

    private func configureNavigationBar() {
        navigationItem.titleView = makeTitleView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(didTapProfile))
    }

    @objc private func didTapTweet() {
        presentNavigation(viewController: TweetFormViewController(), presentationStyle: .fullScreen)
    }

    private func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            if !user.isOnboarded {
                self?.handleOnboardingForm()
            }
        }.store(in: &subscriptions)

        viewModel.$tweets.sink { [weak self] tweets in
            guard tweets != nil else { return }
            DispatchQueue.main.async { [weak self] in
                self?.timelineTableView.reloadData()
            }
        }.store(in: &subscriptions)

        viewModel.$error.sink { [weak self] error in
            guard let error = error else { return }
            self?.presentAlert(title: "Error", message: error)
        }.store(in: &subscriptions)
    }

    private func makeTitleView() -> UIView {
        let sizeValue = 40
        let rect = CGRect(x: 0, y: 0, width: sizeValue, height: sizeValue)
        let logoView = UIImageView()
        logoView.contentMode = .scaleAspectFill
        logoView.frame = rect
        logoView.image = UIImage(named: "TwitterLogo")

        let titleView = UIView(frame: rect)
        titleView.addSubview(logoView)
        return titleView
    }

    @objc func didTapProfile() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        guard let tweets = viewModel.tweets else { return UITableViewCell() }
        cell.configure(with: tweets[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
