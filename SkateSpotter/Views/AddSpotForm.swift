//
//  AddSpotForm.swift
//  SkateSpotter
//
//  Created by Chris Masoud on 7/27/23.
//

import Foundation
import PhotosUI
import SwiftUI

struct AddSpotForm: View {
    @ObservedObject var model = AddSpotViewModel()
    @State private var name = ""
    @State private var description = ""
    @State private var rating = 0
    @State private var latitudeString = ""
    @State private var longitudeString = ""
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var selectedPhotoData: Data?
    @State private var docID = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Enter Spot Information")
                    .font(.title)
                    .fontWeight(.bold)
                TextField("Spot Name", text: $name)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.secondary), lineWidth: 2)
                    }
                TextField("Description", text: $description)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.secondary), lineWidth: 2)
                    }
                TextField("Latitude", text: $latitudeString)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.secondary), lineWidth: 2)
                    }
                TextField("Longitude", text: $longitudeString)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.secondary), lineWidth: 2)
                    }

                HStack {
                    Text("Rating")
                        .foregroundColor(.secondary)
                    Spacer()
                    Picker(selection: $rating, label: Text("Rating")) {
                        ForEach(1 ..< 6) {
                            Text("\($0)")
                        }
                    }
                    .accentColor(Color(.primary))
                }
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.secondary), lineWidth: 2)
                }
                HStack {
                    Text("Select a Photo")
                        .foregroundColor(.secondary)
                    Spacer()
                    PhotosPicker(
                        selection: $selectedPhoto,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Image(systemName: "photo")
                                .foregroundColor(Color(.primary))
                        }
                        .task(id: selectedPhoto) {
                            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                                selectedPhotoData = data
                            }
                        }
                }
                .padding(16)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.secondary), lineWidth: 2)
                }

                Button(action: {
                    var latitude: Double {
                        return Double(latitudeString) ?? 0.0
                    }
                    var longitude: Double {
                        return Double(longitudeString) ?? 0.0
                    }
                    if rating == 0 {
                        rating = 1
                    }
                    if selectedPhotoData != nil {
                        model.uploadDataToFirebase(data: selectedPhotoData!) { result in
                            switch result {
                            case let .success(downloadURLString):
                                model.addData(name: name, description: description, rating: rating + 1, latitude: latitude, longitude: longitude, image: downloadURLString)
                            case let .failure(error):
                                print("Error uploading image: \(error.localizedDescription)")
                            }
                        }
                    } else {
                        model.addData(name: name, description: description, rating: rating + 1, latitude: latitude, longitude: longitude, image: "https://firebasestorage.googleapis.com/v0/b/skatespotter-983ca.appspot.com/o/Screenshot%202023-07-27%20at%203.13.02%20PM.png?alt=media&token=5a24fd13-81f4-4e37-bce6-08383843d292")
                        name = ""
                        description = ""
                        latitudeString = ""
                        longitudeString = ""
                        rating = 0
                    }
                }, label: {
                    CommonButton(text: "Add New Spot", symbol: "plus.circle")
                })
            }
            .padding()
        }
        .onReceive(model.dataAddedPublisher) { _ in
            name = ""
            description = ""
            latitudeString = ""
            longitudeString = ""
            rating = 0
        }
    }
}

#Preview {
    AddSpotForm()
}
