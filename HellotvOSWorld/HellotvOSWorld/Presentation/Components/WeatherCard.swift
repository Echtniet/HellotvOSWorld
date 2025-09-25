//
//  WeatherCard.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

import SwiftUI

struct WeatherCard: View, Equatable {

    func topWeatherComponent() -> some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                //TODO: make desgin system with and implement reusable ui components using custom textStyle
                Text("24°C")
                    .font(.system(size: 32, weight: .bold))
                    .lineSpacing(32 * 0.4)
                    .tracking(0)
                    .multilineTextAlignment(.center)
                Text("Sunny")
                    .font(.system(size: 20, weight: .regular))
                    .lineSpacing(20 * (1.6 - 1))
                    .tracking(0)
            }
            .frame(width: 152, height: 64, alignment: .leading)
            Image(systemName: "sun.max.fill")
                .symbolRenderingMode(.multicolor)
                .frame(width: 50, height: 64)

        }
        .padding(.top, 16)
        .padding(.horizontal, 24)
        .frame(width: 250, height: 80)
    }

    func conditionsWeatherComponent() -> some View {
        VStack(spacing: 0) {
            VStack(spacing: 16) {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 194/255, green: 202/255, blue: 208/255).opacity(0.1),
                                Color.white.opacity(0.1)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            )
        }
        .padding(.horizontal, 8)
        .frame(width: 250, height: 106)
    }

    func hourlyWeatherComponent() -> some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                Text("15:00")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textCase(.uppercase)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .lineSpacing(18 * 0.6)
                    .tracking(0)
                    .foregroundStyle(Color(red: 241/255, green: 241/255, blue: 241/255).opacity(0.5))
                Text("16:00")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .textCase(.uppercase)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .lineSpacing(18 * 0.6)
                    .tracking(0)
                    .foregroundStyle(Color(red: 241/255, green: 241/255, blue: 241/255).opacity(0.5))
                Text("17:00")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .textCase(.uppercase)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .lineSpacing(18 * 0.6)
                    .tracking(0)
                    .foregroundStyle(Color(red: 241/255, green: 241/255, blue: 241/255).opacity(0.5))
            }
            HStack(spacing: 0) {
                HStack(spacing: 4) {
                    Image(systemName: "sun.max.fill")
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 23, height: 29)
                    Text("30°")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .lineSpacing(18 * 0.6)
                        .tracking(0)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 4) {
                    Image(systemName: "sun.max.fill")
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 23, height: 29)
                    Text("30°")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .lineSpacing(18 * 0.6)
                        .tracking(0)

                }
                .frame(maxWidth: .infinity, alignment: .center)
                HStack(spacing: 4) {
                    Image(systemName: "sun.max.fill")
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 23, height: 29)
                    Text("30°")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .lineSpacing(18 * 0.6)
                        .tracking(0)

                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.horizontal, 24)
        .frame(width: 250, height: 66)
    }

    func tomorrowWeatherComponent() -> some View {
        HStack(spacing: 0) {
            Text("TMR")
                .frame(maxWidth: .infinity, alignment: .leading)
                .textCase(.uppercase)
                .font(.system(size: 18, weight: .bold, design: .default))
                .lineSpacing(18 * 0.6)
                .tracking(0)
                .foregroundStyle(Color(red: 241/255, green: 241/255, blue: 241/255).opacity(0.5))
            Image(systemName: "sun.max.fill")
                .symbolRenderingMode(.multicolor)
                .frame(width: 29, height: 29)
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
        .padding(.bottom, 16)
        .padding(.horizontal, 24)
        .frame(width: 250, height: 45)
    }

    var body: some View {
        VStack(spacing: 0) {
            topWeatherComponent()
            Spacer()
            conditionsWeatherComponent()
            Spacer()
            hourlyWeatherComponent()
            Spacer()
            tomorrowWeatherComponent()
        }
        //TODO: viewModifier for card or creat custom cardStyle tbd
        .frame(width: 250, height: 400)
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
