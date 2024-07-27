//
//  HomeViewModel.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 25.07.2024.
//

import Combine
import FirebaseAuth
import Foundation

final class HomeViewModel: ObservableObject {
    @Published var user: AppUser?
    @Published var error: String?
    @Published var tweets: [Tweet]?

    private var subscriptions = Set<AnyCancellable>()

    func getUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUser(get: id).handleEvents(receiveOutput: { [weak self] user in
            self?.user = user
            self?.getTimeLineTweets()
        }).sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] user in
            self?.user = user
        }
        .store(in: &subscriptions)
    }

    func getTimeLineTweets() {
        guard let user = user, user.fallowingIds.count > 0 else { return }
        DatabaseManager.shared.collectionTweets(getTimeLine: user.fallowingIds).sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] tweets in
            self?.tweets = tweets
        }.store(in: &subscriptions)
    }
}
