//
//  UIViewController+Extensions.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 16.07.2024.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }

    func presentNavigation(viewController: UIViewController, presentationStyle: UIModalPresentationStyle) {
        let view = UINavigationController(rootViewController: viewController)
        view.modalPresentationStyle = .fullScreen
        present(view, animated: true)
    }
}
