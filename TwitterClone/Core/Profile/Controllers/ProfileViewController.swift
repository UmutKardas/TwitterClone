//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 1.06.2024.
//

import Combine
import UIKit

class ProfileViewController: UIViewController {
    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var headerView = ProfileTableViewHeader(
        frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 390)
    )
    private let viewModel = ProfileViewModel()
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.tableHeaderView = headerView
        view.addSubview(profileTableView)
        configureConstraints()
        bindView()
        viewModel.getUser()
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func bindView() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            self?.headerView.configure(with: user)
        }.store(in: &subscriptions)

        viewModel.$error.sink { [weak self] error in
            guard let error = error else { return }
            self?.presentAlert(title: "Error", message: error)
        }.store(in: &subscriptions)

        viewModel.$tweets.sink { [weak self] tweets in
            guard tweets != nil else { return }
            DispatchQueue.main.async {
                self?.profileTableView.reloadData()
            }
        }.store(in: &subscriptions)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return TweetTableViewCell()
        }
        cell.configure(with: viewModel.tweets![indexPath.row])
        return cell
    }
}
