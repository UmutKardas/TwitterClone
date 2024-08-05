//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 30.07.2024.
//

import Combine
import FirebaseAuth
import Foundation

final class ProfileViewModel {
    @Published var user: AppUser?
    @Published var tweets: [Tweet]?
    @Published var error: String?

    private var subscriptions = Set<AnyCancellable>()

    func getUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUser(get: id)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
                self?.getUserTweets()
            }
            .store(in: &subscriptions)
    }

    func getUserTweets() {
        guard let user = user else { return }
        DatabaseManager.shared.collectionTweets(getTweets: user.id)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] tweets in
                self?.tweets = tweets
            }
            .store(in: &subscriptions)
    }
}
