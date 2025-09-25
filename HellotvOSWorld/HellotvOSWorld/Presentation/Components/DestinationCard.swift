//
//  DestinationCard.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

import SwiftUI

struct DestinationCard: View, Equatable {

    let model: DashboardWidget

    func destinationHeading() -> some View {
        HStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 0) {
                Text("CURRENT STOP")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textCase(.uppercase)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .lineSpacing(18 * 0.6)
                    .tracking(0)
                    .foregroundStyle(Color(red: 241/255, green: 241/255, blue: 241/255).opacity(0.5))
                Spacer()
                Text(model.currentStopName)
                    .font(.system(size: 32, weight: .bold))
                    .lineSpacing(32 * 0.4)
                    .tracking(0)
                Spacer()
                Text(model.currentStopNameWithFlag)
                    .font(.system(size: 25, weight: .regular, design: .default))
                    .lineSpacing(25 * 0.5)
                    .tracking(0)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(width: 313, height: 148)
            VStack {
                CachedImageView(url: URL(string: "https://api1.superyachtapi.com/api/yachteye/customers/stream-file/https%3A%2F%2Fcdn.yachteye.com%2Fyachts%2FY028000000%2Fphoto%2FDemoYacht_Anchored.jpg")!, viewModel: DIContainer.shared.resolve(CachedImageViewModel.self))
                    .frame(width: 205, height: 140)
                    .cornerRadius(16)
            }
                .padding(.top, 8)
                .padding(.trailing, 8)
                .frame(width: 213, height: 148)

        }
        .frame(width: 550, height: 148)
    }

    func destinationDescription() -> some View {
        VStack(spacing: 0) {
            Text("Charming and bohemian Antibes offers visitors a break from hectic city life. Explore the enchanting old town, captivating hidden coves and bewitching turquoise blue waters.")
                .font(.system(size: 20, weight: .regular, design: .default))
                .lineSpacing(20 * 0.6)
                .tracking(0)

        }
        .padding(.horizontal, 24)
        .frame(width: 550, height: 128)
    }

    func destinationNextStop() -> some View {
        HStack(spacing: 0) {
            Text("NEXT STOP")
                .frame(maxWidth: .infinity, alignment: .leading)
                .textCase(.uppercase)
                .font(.system(size: 18, weight: .bold, design: .default))
                .lineSpacing(18 * 0.6)
                .foregroundStyle(Color(red: 241/255, green: 241/255, blue: 241/255).opacity(0.5))

            Text(model.nextStopDate)
                .frame(maxWidth: .infinity, alignment: .center)
                .textCase(.uppercase)
                .font(.system(size: 18, weight: .bold, design: .default))
                .lineSpacing(18 * 0.6)

            Text(model.nextStopName)
                .frame(width: 150)
                .textCase(.uppercase)
                .font(.system(size: 18, weight: .bold, design: .default))
                .lineSpacing(18 * 0.6)
                .tracking(0)

            Text("27°")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 18, weight: .bold, design: .default))
                .lineSpacing(18 * 0.6)
                .tracking(0)
            Text("/18°")
                .font(.system(size: 18, weight: .bold, design: .default))
                .lineSpacing(18 * 0.6)
                .tracking(0)
                .foregroundStyle(Color(red: 241/255, green: 241/255, blue: 241/255).opacity(0.5))
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .frame(width: 550, height: 61)
    }

    var body: some View {
        VStack(spacing: 0) {
            destinationHeading()
            Spacer()
            destinationDescription()
            Spacer()
            destinationNextStop()
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

extension DashboardWidget {
    var currentStopName: String {
        switch self {
        case .itinerary(_, let currentStop, _, _, _, _, _, _, _, _, _):
            return currentStop.destinationName
        default:
            return ""
        }
    }

    var currentStopNameWithFlag: String {
        switch self {
        case .itinerary(_, let currentStop, _, _, _, _, _, _, _, _, _):
            return currentStop.destinationCountry
        default:
            return ""
        }
    }

    var nextStopName: String {
        switch self {
        case .itinerary(_, _, let nextStop, _, _, _, _, _, _, _, _):
            return nextStop.destinationName
        default:
            return ""
        }
    }

    var nextStopDate: String {
        switch self {
        case .itinerary(_, _, let nextStop, _, _, _, _, _, _, _, _):
            return nextStop.destinationCountry
        default:
            return ""
        }
    }
}
