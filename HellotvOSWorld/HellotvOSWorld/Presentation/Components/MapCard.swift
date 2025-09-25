//
//  MapCard.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

import SwiftUI

struct MapCard: View, Equatable {
    var body: some View {
        VStack {

        }
        .frame(width: 550, height: 400)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(.gray, lineWidth: 1)
                }
        )
    }
}
