//
//  SpotList.swift
//  SkateSpotter
//
//  Created by Chris Masoud on 7/26/23.
//

import Foundation
import SwiftUI

struct SpotList: View {
    
    @ObservedObject var model = ListViewModel()
    
    var body: some View {
        NavigationView {
            List(model.list) { spot in
                NavigationLink(destination: SpotDetails(spot: spot), label: {
                    SpotCell(spot: spot)
                })
            }
            .listRowSpacing(10)
            .navigationTitle("Discover Spots")
            .onAppear {
                model.getData()
            }
        }
        .accentColor(Color(.secondary))
    }
    
    init() {
        model.getData()
    }
}

#Preview {
    SpotList()
}
