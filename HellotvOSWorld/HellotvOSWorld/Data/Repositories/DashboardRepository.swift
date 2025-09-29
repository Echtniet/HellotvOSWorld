//
//  DashboardRepository.swift
//  HellotvOSWorld
//
//  Created by Clinton on 22/09/2025.
//

protocol DashboardRepositoryProtocol {
    func fetchDashboard(for name: String, lastname: String, forcedRefresh: Bool) async throws -> Dashboard
}

class DashboardRepository: DashboardRepositoryProtocol {
    private let apiService: APIServiceProtocol
    private let dataCache: DataCache<Dashboard>

    private var ongoingTask: Task<Dashboard, Error>?

    init(
        apiService: APIServiceProtocol,
        dataCache: DataCache<Dashboard>
    ) {
        self.apiService = apiService
        self.dataCache = dataCache
    }

    func fetchDashboard(for name: String, lastname: String, forcedRefresh: Bool = false) async throws -> Dashboard {
        if !forcedRefresh {
            if let cachedDashboard = await dataCache.get() {
                return cachedDashboard
            }

            if let ongoingTask {
                return try await ongoingTask.value
            }
        } else {
            ongoingTask?.cancel()
        }

        let task = Task {
            defer { ongoingTask = nil }

            do {
                guard !Task.isCancelled else {
                    throw CancellationError()
                }
                let dashboardDTO = try await apiService.fetchDashboard(for: name, lastname: lastname, forcedRefresh: forcedRefresh)

                let dashboard = Dashboard(dto: dashboardDTO)
                await dataCache.set(dashboard)
                return dashboard
            } catch is CancellationError {
                if let ongoingTask {
                    return try await ongoingTask.value
                }
                throw CancellationError()
            }
        }
        ongoingTask = task
        return try await task.value
    }
}
