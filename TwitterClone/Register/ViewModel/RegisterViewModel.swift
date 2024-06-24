//
//  RegisterViewModel.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 24.06.2024.
//

import Foundation

final class RegisterViewModel: ObservableObject {
    @Published var email: String?
    @Published var password: String?
    @Published var error: String?

    func createUser() {}
}
