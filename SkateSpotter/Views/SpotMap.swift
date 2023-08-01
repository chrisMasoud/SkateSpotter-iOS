//
//  Map.swift
//  SkateSpotter
//
//  Created by Chris Masoud on 7/25/23.
//

import MapKit
import SwiftUI

struct SpotMap: View {
    @ObservedObject var model = ListViewModel()
    @State var test = ""
    @State var camera: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $camera) {
            ForEach(model.list) { spot in
                Marker("\(spot.name)", systemImage: "figure.skating", coordinate: CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude))
            }
        }
        .onAppear {
            model.getData()
        }
    }

    init() {
        model.getData()
    }
}

#Preview {
    SpotMap()
}
