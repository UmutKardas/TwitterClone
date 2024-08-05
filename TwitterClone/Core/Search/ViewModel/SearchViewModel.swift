//
//  SearchViewModel.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 5.08.2024.
//

import Combine
import Foundation

final class SearchViewModel: ObservableObject {
    @Published var error: String?

    private var subscriptions = Set<AnyCancellable>()

    func searchUser(with text: String, completion: @escaping ([AppUser]) -> Void) {
        DatabaseManager.shared.collectionUser(search: text).sink { [weak self] completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        } receiveValue: { users in
            completion(users)
        }.store(in: &subscriptions)
    }
}
