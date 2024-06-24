//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 29.05.2024.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {
    private let timelineTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timelineTableView)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.frame
        configureConstrains()
        configureNavigationBar()
        handleAuthentication()
    }

    private func configureConstrains() {}

    private func handleAuthentication() {
        if Auth.auth().currentUser != nil { return }

        let onboardingView = UINavigationController(rootViewController: OnboardingViewController())
        onboardingView.modalPresentationStyle = .fullScreen
        present(onboardingView, animated: true)
    }

    private func configureNavigationBar() {
        navigationItem.titleView = makeTitleView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(didTapProfile))
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
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
