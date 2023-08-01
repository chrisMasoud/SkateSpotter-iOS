//
//  AddSpotViewModel.swift
//  SkateSpotter
//
//  Created by Chris Masoud on 7/27/23.
//

import Combine
import Firebase
import FirebaseStorage
import Foundation

class AddSpotViewModel: ObservableObject {
    let dataAddedPublisher = PassthroughSubject<Void, Never>()

    func addData(name: String, description: String, rating: Int, latitude: Double, longitude: Double, image: String) {
        let db = Firestore.firestore()
        db.collection("Spots").addDocument(data: ["name": name,
                                                  "description": description,
                                                  "rating": rating,
                                                  "latitude": latitude,
                                                  "longitude": longitude,
                                                  "image": image]) { error in
            if error == nil {
                print("Document added successfully")
                self.dataAddedPublisher.send()
            } else {
                print("Error adding document")
            }
        }
    }

    func uploadDataToFirebase(data: Data, completion: @escaping (Result<String, Error>) -> Void) {
        let storageRef = Storage.storage().reference()
        let uniqueImageID = UUID().uuidString
        let imageRef = storageRef.child("\(uniqueImageID).jpg")
        _ = imageRef.putData(data, metadata: nil) { _, error in
            if let error = error {
                print("Error uploading data: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            imageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }

                if let downloadURL = url?.absoluteString {
                    print("Data uploaded!")
                    completion(.success(downloadURL))
                } else {
                    let error = NSError(domain: "com.yourapp.firebase", code: -1, userInfo: [NSLocalizedDescriptionKey: "Download URL not available"])
                    completion(.failure(error))
                }
            }
        }
    }
}
