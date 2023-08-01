//
//  CellViewModel.swift
//  SkateSpotter
//
//  Created by Chris Masoud on 7/26/23.
//

import Firebase
import FirebaseStorage
import Foundation

class ImageViewModel: ObservableObject {
    func downloadImage(downloadURL: String, completion: @escaping (UIImage?) -> Void) {
        let storage = Storage.storage()
        let httpsReference = storage.reference(forURL: downloadURL)

        httpsReference.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                print("Error: Image data is invalid or nil.")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    func starRatingString(for rating: Int) -> String {
        var stars = ""
        for _ in 1 ... rating {
            stars += "⭐️"
        }
        return stars
    }
}
