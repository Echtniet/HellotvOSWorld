//
//  DashboardViewModel.swift
//  HellotvOSWorld
//
//  Created by Clinton on 22/09/2025.
//

import Combine
import Foundation
import Observation

@Observable
@MainActor
class DashboardViewModel {
    var dashboard: Dashboard?

    @ObservationIgnored private var firstLoad: Bool = true
    var isLoading: Bool = false
    var errorMessage: String?

    @ObservationIgnored private let dashboardUseCase: DashboardUseCaseProtocol
    @ObservationIgnored private var fetchDashboardTask: Task<Void, Never>?
    @ObservationIgnored private var timerTask: Task<Void, Never>?

    @ObservationIgnored private var cancellables = Set<AnyCancellable>()


    init(dashboardUseCase: DashboardUseCaseProtocol) {
        self.dashboardUseCase = dashboardUseCase
    }

    func fetchDashboard(forcedRefersh: Bool = false) {
        fetchDashboardTask?.cancel()
        fetchDashboardTask = Task {
            if firstLoad {
                isLoading = true
                firstLoad = false
            }
            errorMessage = nil

            do {
                guard !Task.isCancelled else { return }
                dashboard = try await dashboardUseCase.execute(for: "Clinton", lastname: "Davelaar", forcedRefresh: forcedRefersh)
            } catch is CancellationError {
                print("Log: Cancelled fetch dashboard task")
            } catch {
                errorMessage = "Error: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }

    func startAutoRefresh() {
        timerTask?.cancel()
        timerTask = Task {
            while !Task.isCancelled {
                fetchDashboard()
                try? await Task.sleep(nanoseconds: 60_000_000_000)
            }
        }
    }

    func stopAutoRefresh() {
        timerTask?.cancel()
    }
}
