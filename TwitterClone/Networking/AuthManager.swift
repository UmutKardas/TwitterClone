//
//  AuthManager.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 26.06.2024.
//

import Combine
import CombineFirebaseAuthentication
import FirebaseAuth
import Foundation

class AuthManager {
    static let shared = AuthManager()

    func createUser(email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }

    func signIn(email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
}
