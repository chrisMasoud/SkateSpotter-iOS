//
//  SpotCell.swift
//  SkateSpotter
//
//  Created by Chris Masoud on 7/26/23.
//

import Foundation
import SwiftUI

let test = Spot(id: "test", name: "test", description: "This is a test description to see how msny lines we can get and fit in the cell", latitude: 40.71648, longitude: -73.91763, image: "https://firebasestorage.googleapis.com/v0/b/skatespotter-983ca.appspot.com/o/1687281657844-gap_6set-2-300x225.jpg?alt=media&token=ea270188-a1b0-4de4-a1d1-b6540d592222", rating: 4)

struct SpotCell: View {
    
    var spot: Spot
    @ObservedObject var model = ImageViewModel()
    @State var spotImage: UIImage?
    
    var body: some View {
        
        HStack {
            if let image = spotImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 120, height: 70)
                    .cornerRadius(4)
                    .padding(.vertical, 4)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(spot.name)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                
                Text("\(spot.latitude)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                Text("\(spot.longitude)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
            }
        }
        .onAppear {
            model.downloadImage(downloadURL: spot.image) { image in
                spotImage = image
            }
        }
        
    }
}

#Preview {
    SpotCell(spot: test)
}
