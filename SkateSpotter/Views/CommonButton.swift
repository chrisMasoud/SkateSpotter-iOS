//
//  CommonButton.swift
//  SkateSpotter
//
//  Created by Chris Masoud on 7/26/23.
//

import Foundation
import SwiftUI

struct CommonButton: View {
    var text: String
    var symbol: String

    var body: some View {
        HStack {
            Image(systemName: symbol)

            Text(text)
                .bold()
                .font(.title2)
        }
        .frame(width: 280, height: 50)
        .background(Color(.primary))
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

#Preview {
    CommonButton(text: "Hello", symbol: "photo")
}
