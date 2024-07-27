//
//  StorageManager.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 27.07.2024.
//

import Combine
import CombineFirebaseStorage
import FirebaseFirestoreSwift
import FirebaseStorage
import Foundation

class StorageManager {
    static let shared = StorageManager()
    let storage = Storage.storage()

    func uploadProfileImage(with randomID: String, image: Data, metadata: StorageMetadata) -> AnyPublisher<StorageMetadata, Error> {
        storage.reference().child("images\(randomID).jpg").putData(image).print().eraseToAnyPublisher()
    }

    func getDownloadUrl(for id: String?) -> AnyPublisher<URL, Error> {
        guard let id = id else { return Fail(error: "Invalid image id" as! Error).eraseToAnyPublisher() }
        return storage.reference(withPath: id).downloadURL().print().eraseToAnyPublisher()
    }
}
