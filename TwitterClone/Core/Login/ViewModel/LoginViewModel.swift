//
//  LoginViewModel.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 16.07.2024.
//

import Combine
import FirebaseAuth
import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email: String?
    @Published var password: String?
    @Published var error: String?
    @Published var user: User?
    @Published var successAction: (() -> Void)?

    private var subscriptions = Set<AnyCancellable>()

    func loginUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.signIn(email: email, password: password).handleEvents(receiveOutput: { [weak self] user in self?.user = user }).sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] user in
            self?.user = user
            self?.successAction?()
        }.store(in: &subscriptions)
    }
}
