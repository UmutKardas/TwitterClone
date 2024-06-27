//
//  User.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 2.06.2024.
//

import Foundation

struct AppUser: Codable, Hashable {
    var id: UUID = .init()
    var username: String
    var displayName: String
    var biography: String
    var createdDate: Date = .init()
    var avatarData: String
    var fallowerValue: Int
    var fallowingValue: Int
}
