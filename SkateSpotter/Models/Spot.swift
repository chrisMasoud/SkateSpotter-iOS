//
//  Spot.swift
//  SkateSpotter
//
//  Created by Chris Masoud on 7/26/23.
//

import Foundation

struct Spot: Identifiable {
    var id: String
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    var image: String
    var rating: Int
}
