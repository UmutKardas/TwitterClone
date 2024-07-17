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
    let database = Firestore.firestore()
    let usersPath: String = "users"

    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let appUser = AppUser(from: user)
        return database.collection(usersPath).document(appUser.id).setData(from: appUser).map { _ in true }.eraseToAnyPublisher()
    }
}
