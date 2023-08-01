//
//  SpotDetails.swift
//  SkateSpotter
//
//  Created by Chris Masoud on 7/26/23.
//

import Foundation
import SwiftUI

struct SpotDetails: View {
    var spot: Spot
    @ObservedObject var model = ImageViewModel()
    @State var spotImage: UIImage?

    var body: some View {
        VStack(spacing: 20) {
            if let image = spotImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .cornerRadius(12)
            }

            Text(spot.name)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            HStack(spacing: 20) {
                Label("\(spot.latitude)", systemImage: "location.fill")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("\(spot.longitude)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Text("Rating: \(model.starRatingString(for: spot.rating))")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("\(spot.description)")
                .font(.body)
                .padding()
        }
        .onAppear {
            model.downloadImage(downloadURL: spot.image) { image in
                spotImage = image
            }
        }
    }
}

#Preview {
    SpotDetails(spot: test)
}
