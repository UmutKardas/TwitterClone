//
//  User.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 2.06.2024.
//

import Firebase
import Foundation

struct AppUser: Codable, Hashable {
    let id: String
    var username: String = ""
    var displayName: String = ""
    var biography: String = ""
    var createdDate: Date = .init()
    var avatarData: String = ""
    var fallowerValue: Int = 0
    var fallowingValue: Int = 0

    init(from user: User) {
        self.id = user.uid
    }
}
