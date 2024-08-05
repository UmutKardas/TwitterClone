//
//  MainTabBarViewController.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 29.05.2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let homeView = UINavigationController(rootViewController: HomeViewController())
        let searchView = UINavigationController(rootViewController: SearchViewController(viewModel: SearchViewModel()))
        let notificationView = UINavigationController(rootViewController: NotificationsViewController())
        let directMessagesView = UINavigationController(rootViewController: DirectMessagesViewController())

        homeView.tabBarItem.image = UIImage(systemName: "house")
        homeView.tabBarItem.selectedImage = UIImage(systemName: "house.fill")

        searchView.tabBarItem.image = UIImage(systemName: "magnifyingglass")

        notificationView.tabBarItem.image = UIImage(systemName: "bell")
        notificationView.tabBarItem.selectedImage = UIImage(systemName: "bell.fill")

        directMessagesView.tabBarItem.image = UIImage(systemName: "message")
        directMessagesView.tabBarItem.selectedImage = UIImage(systemName: "message.fill")

        setViewControllers([homeView, searchView, notificationView, directMessagesView], animated: true)
    }
}
