//
//  ProfileFormViewModel.swift
//  TwitterClone
//
//  Created by Hüseyin Umut Kardaş on 27.07.2024.
//

import Combine
import FirebaseAuth
import FirebaseStorage
import Foundation
import UIKit

final class ProfileFormViewModel {
    @Published var imageData: UIImage?
    @Published var imagePath: String?
    @Published var displayName: String?
    @Published var username: String?
    @Published var biography: String?
    @Published var error: String?
    @Published var successAction: (() -> Void)?

    private var subscriptions = Set<AnyCancellable>()

    func submit() {
        print("submit")
        uploadImageData()
    }

    func uploadImageData() {
        guard let imageData = imageData?.jpegData(compressionQuality: 50) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"

        StorageManager.shared.uploadProfileImage(with: UUID().uuidString, image: imageData, metadata: metaData).flatMap { metaData in
            StorageManager.shared.getDownloadUrl(for: metaData.path)
        }.sink { [weak self] completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] url in
            self?.imagePath = url.absoluteString
            self?.updateUserData()
        }.store(in: &subscriptions)
    }

    private func updateUserData() {
        guard let displayName,
              let username,
              let biography,
              let imagePath,
              let id = Auth.auth().currentUser?.uid else { return }
        let updatedFields: [String: Any] = [
            UserModelConstants.Keys.displayNameKey: displayName,
            UserModelConstants.Keys.usernameKey: username,
            UserModelConstants.Keys.biographyKey: biography,
            UserModelConstants.Keys.avatarDataKey: imagePath,
            UserModelConstants.Keys.isOnboardedKey: true
        ]

        DatabaseManager.shared.collectionUser(update: id, updatedFields: updatedFields).sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] _ in
            self?.successAction?()
        }.store(in: &subscriptions)
    }
}
