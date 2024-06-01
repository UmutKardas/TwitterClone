//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 1.06.2024.
//

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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.tableHeaderView = headerView
        view.addSubview(profileTableView)
        configureConstraints()
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return TweetTableViewCell()
        }
        return cell
    }
}
