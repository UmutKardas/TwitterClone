//
//  SearchViewController.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 29.05.2024.
//

import UIKit

class SearchViewController: UIViewController {
    let searchController: UISearchController = {
        let resultsController = SearchTableView()
        let search = UISearchController(searchResultsController: UINavigationController(rootViewController: resultsController))
        search.searchBar.searchBarStyle = .minimal
        search.searchBar.placeholder = "Search in X"
        return search
    }()

    private let promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Search for users"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .placeholderText
        return label
    }()

    let viewModel: SearchViewModel = .init()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(promptLabel)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        configureConstrains()
    }

    private func configureConstrains() {
        NSLayoutConstraint.activate([
            promptLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func pushToProfile(with user: AppUser) {
        let profileViewController = ProfileViewController(userID: user.id)
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let navigationController = searchController.searchResultsController as? UINavigationController,
              let resultsViewController = navigationController.topViewController as? SearchTableView,
              let text = searchController.searchBar.text else { return }

        viewModel.searchUser(with: text) { users in
            resultsViewController.updateView(users: users)
        }
    }
}
