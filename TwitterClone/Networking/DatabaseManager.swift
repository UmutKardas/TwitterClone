//
//  DatabaseManager.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 17.07.2024.
//

import Combine
import CombineFirebaseFirestore
import Firebase
import FirebaseFirestoreSwift
import Foundation

class DatabaseManager {
    static let shared = DatabaseManager()

    private let database = Firestore.firestore()
    private let usersPath: String = "users"
    private let tweetPath: String = "tweets"

    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let appUser = AppUser(from: user)
        return database.collection(usersPath).document(appUser.id).setData(from: appUser).map { _ in true }.eraseToAnyPublisher()
    }

    func collectionUser(get id: String) -> AnyPublisher<AppUser, Error> {
        return database.collection(usersPath).document(id).getDocument().tryMap { snapshot in
            try snapshot.data(as: AppUser.self)
        }.eraseToAnyPublisher()
    }

    func collectionUser(update id: String, updatedFields: [AnyHashable: Any]) -> AnyPublisher<Bool, Error> {
        return database.collection(usersPath).document(id).updateData(updatedFields).map { _ in
            true
        }.eraseToAnyPublisher()
    }

    func collectionTweets(getTimeLine userIds: [String]) -> AnyPublisher<[Tweet], Error> {
        let publishers = userIds.map { userID in
            database.collection(tweetPath).whereField("author.id", isEqualTo: userID).getDocuments().tryMap { snapshots in
                try snapshots.documents.map { snapshot in
                    try snapshot.data(as: Tweet.self)
                }
            }
        }

        return Publishers.MergeMany(publishers).collect().map { $0.flatMap { $0 }}.eraseToAnyPublisher()
    }

    func collectionTweets(getTweets userId: String) -> AnyPublisher<[Tweet], Error> {
        return database.collection(tweetPath).whereField("author.id", isEqualTo: userId).getDocuments().tryMap { snapshots in
            try snapshots.documents.map { snapshot in
                try snapshot.data(as: Tweet.self)
            }
        }.eraseToAnyPublisher()
    }
}
