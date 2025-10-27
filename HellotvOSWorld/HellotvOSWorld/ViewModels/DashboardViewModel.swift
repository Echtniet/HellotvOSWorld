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
        print("Log: Fetching dashboard")
        fetchDashboardTask?.cancel()
        fetchDashboardTask = Task(priority: .userInitiated) {
            await MainActor.run {
                if firstLoad {
                    isLoading = true
                    firstLoad = false
                }
                errorMessage = nil
            }

            defer { Task { await MainActor.run { isLoading = false } } }

            do {
                guard !Task.isCancelled else { return }
                let result = try await dashboardUseCase.execute(for: "Clinton", lastname: "Davelaar", forcedRefresh: forcedRefersh)

                await MainActor.run {
                    print("dashboard updated")
                    dashboard = result
                }
            } catch is CancellationError {
                print("Log: Cancelled fetch dashboard task")
            } catch {
                await MainActor.run {
                    errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }

    func startAutoRefresh() {
        timerTask?.cancel()
        timerTask = Task {
            while !Task.isCancelled {
                fetchDashboard()
                try? await Task.sleep(nanoseconds: 10_000_000_000)
            }
        }
    }

    func stopAutoRefresh() {
        timerTask?.cancel()
    }
}

//final class DashboardViewModel: ObservableObject {
//    @Published var dashboard: Dashboard?
//    @Published var isLoading: Bool = false
//    @Published var errorMessage: String?
//
//    private var firstLoad: Bool = true
//    private let dashboardUseCase: DashboardUseCaseProtocol
//    private var fetchDashboardTask: Task<Void, Never>?
//    private var timerTask: Task<Void, Never>?
//    private var cancellables = Set<AnyCancellable>()
//
//    init(dashboardUseCase: DashboardUseCaseProtocol) {
//        self.dashboardUseCase = dashboardUseCase
//    }
//
//    func fetchDashboard(forcedRefersh: Bool = false) {
//        print("Log: Fetching dashboard")
//        fetchDashboardTask?.cancel()
//        fetchDashboardTask = Task(priority: .userInitiated) {
//            await MainActor.run {
//                if self.firstLoad {
//                    self.isLoading = true
//                    self.firstLoad = false
//                }
//                self.errorMessage = nil
//            }
//
//            defer {
//                Task { @MainActor in
//                    self.isLoading = false
//                }
//            }
//
//            do {
//                guard !Task.isCancelled else { return }
//
//                let result = try await self.dashboardUseCase.execute(
//                    for: "Clinton",
//                    lastname: "Davelaar",
//                    forcedRefresh: forcedRefersh
//                )
//
//                await MainActor.run {
//                    print("dashboard updated")
//                    self.dashboard = result
//                }
//
//            } catch is CancellationError {
//                print("Log: Cancelled fetch dashboard task")
//            } catch {
//                await MainActor.run {
//                    self.errorMessage = "Error: \(error.localizedDescription)"
//                }
//            }
//        }
//    }
//
//    func startAutoRefresh() {
//        timerTask?.cancel()
//        timerTask = Task {
//            while !Task.isCancelled {
//                fetchDashboard()
//                try? await Task.sleep(nanoseconds: 10_000_000_000) // 10 seconds
//            }
//        }
//    }
//
//    func stopAutoRefresh() {
//        timerTask?.cancel()
//    }
//}
