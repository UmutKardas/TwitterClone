//
//  SearchViewController.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 29.05.2024.
//

import UIKit

class SearchViewController: UIViewController {
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: SearchTableView())
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

    let viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
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
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultsViewController = searchController.searchResultsController as? SearchTableView, let text = searchController.searchBar.text else { return }
        viewModel.searchUser(with: text) { users in
            resultsViewController.updateView(users: users)
        }
    }
}
