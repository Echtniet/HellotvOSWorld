//
//  ContentView.swift
//  HellotvOSWorld
//
//  Created by Clinton on 21/09/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DashboardView(viewModel: DIContainer.shared.resolve(DashboardViewModel.self))
    }
}

#Preview {
    ContentView()
}
