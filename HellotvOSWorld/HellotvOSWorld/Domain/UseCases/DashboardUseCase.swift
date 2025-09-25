//
//  DashboardUseCase.swift
//  HellotvOSWorld
//
//  Created by Clinton on 22/09/2025.
//

protocol DashboardUseCaseProtocol {
    func execute(for name: String, lastname: String, forcedRefresh: Bool) async throws -> Dashboard
}

class DashboardUseCase: DashboardUseCaseProtocol {
    private let repository: DashboardRepositoryProtocol

    init(repository: DashboardRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for name: String, lastname: String, forcedRefresh: Bool = false) async throws -> Dashboard {
        return try await repository.fetchDashboard(for: name, lastname: lastname, forcedRefresh: forcedRefresh)
    }

}
