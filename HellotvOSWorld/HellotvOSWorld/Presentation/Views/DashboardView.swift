//
//  DashboardView.swift
//  HellotvOSWorld
//
//  Created by Clinton on 24/09/2025.
//

import MapKit
import SwiftUI

struct DashboardView: View {
    @State private var viewModel: DashboardViewModel

    @FocusState private var focusedID: UUID?

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text("\(errorMessage)")
            } else if let dashboard = viewModel.dashboard {
                Spacer()
                Text(dashboard.welcomeWithUser)
                    .padding(.horizontal, 80)
                    .font(.system(size: 25, weight: .bold, design: .default))
                    .lineSpacing(25 * 0.4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 40) {
                        ForEach(dashboard.widgets, id: \.self) { widget in
                            EquatableView(content:
                                DashboardCard(model: widget)
                            )
                            .scaleEffect(focusedID == widget.id ? 1.05 : 1.0)
                            .animation(.easeInOut(duration: 0.2), value: focusedID)
                            .focusable()
                            .focused($focusedID, equals: widget.id)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding(.horizontal, 80)
                .frame(height: 420)
                Text("YATCHEYE")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .textCase(.uppercase)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .lineSpacing(18 * 0.6)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            if viewModel.dashboard?.useMap == true {
                Map()
            } else {
                if let imageURL = viewModel.dashboard?.backgroundImage {
                    EquatableView(
                        content: CachedImageView(url: imageURL, blurry: true, viewModel: DIContainer.shared.resolve(CachedImageViewModel.self))
                  )
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.startAutoRefresh()
        }
    }
}

