//
//  MapViewModel.swift
//  SkateSpotter
//
//  Created by Chris Masoud on 7/26/23.
//
import Firebase
import FirebaseFirestore
import Foundation

class ListViewModel: ObservableObject {
    @Published var list = [Spot]()

    func getData() {
        let db = Firestore.firestore()

        db.collection("Spots").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { d in
                            Spot(id: d.documentID,
                                 name: d["name"] as? String ?? "",
                                 description: d["description"] as? String ?? "",
                                 latitude: d["latitude"] as? Double ?? 0.0,
                                 longitude: d["longitude"] as? Double ?? 0.0,
                                 image: d["image"] as? String ?? "",
                                 rating: d["rating"] as? Int ?? 0)
                        }
                    }
                } else {
                    print("Empty")
                }
            } else {
                print("Error")
            }
        }
    }
}
