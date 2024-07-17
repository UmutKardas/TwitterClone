//
//  RegisterViewModel.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 24.06.2024.
//

import Combine
import Firebase
import Foundation

final class RegisterViewModel: ObservableObject {
    @Published var email: String?
    @Published var password: String?
    @Published var error: String?
    @Published var user: User?
    @Published var successAction: (() -> Void)?

    private var subscriptions = Set<AnyCancellable>()

    func createUser() {
        guard let email = email, let password = password else { return }

        AuthManager.shared.createUser(email: email, password: password).handleEvents(receiveOutput: { [weak self] user in self?.user = user })
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.recordUser(user: user)
            }
            .store(in: &subscriptions)
    }

    func recordUser(user: User) {
        DatabaseManager.shared.collectionUsers(add: user).sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        } receiveValue: { state in
            print("Adding user record to database: \(state)")
            self.successAction?()
        }.store(in: &subscriptions)
    }
}
