//
//  TweetFormViewModel.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 4.08.2024.
//

import Combine
import FirebaseAuth
import Foundation

final class TweetFormViewModel: ObservableObject {
    @Published var user: AppUser?
    @Published var tweetText: String?
    @Published var error: String?

    private var subscriptions = Set<AnyCancellable>()

    func getUser() {
        guard let user = Auth.auth().currentUser else { return }
        DatabaseManager.shared.collectionUser(get: user.uid).sink { [weak self] completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] user in
            self?.user = user
        }.store(in: &subscriptions)
    }

    func sendTweet(completionAction: (() -> Void)?) {
        guard let user = user, let tweetText = tweetText else { return }
        let tweet = Tweet(author: user, authorID: user.id, content: tweetText, likesValue: 0, likes: [])
        DatabaseManager.shared.collectionTweets(add: tweet).sink { [weak self] completion in
            switch completion {
            case .finished: break
            case .failure(let error): self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] success in
            if success { completionAction?() }
        }.store(in: &subscriptions)
    }
}
