//
//  Tweet.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 2.06.2024.
//

import Foundation

struct Tweet: Codable {
    var id: UUID = .init()
    var author: AppUser
    var authorID: String
    var content: String
    var likesValue: Int
    var likes: [String]
}
