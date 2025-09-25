//
//  DIContainer.swift
//  HellotvOSWorld
//
//  Created by Clinton on 23/09/2025.
//

import Swinject

@MainActor
class DIContainer {
    static let shared = DIContainer()
    let container: Container

    private init() {
        container = Container()

        registerServices()
        registerDataCaches()
        registerRepositories()
        registerUseCases()
        registerViewModels()
    }

    private func registerServices() {
        #if DEBUG
        //TODO: make mock container for consisten data
        container.register(APIServiceProtocol.self) { _ in
            MockAPIService()
        }
        .inObjectScope(.weak)
        #else
        container.register(APIServiceProtocol.self) { _ in
            APIService()
        }
        .inObjectScope(.weak)
        #endif
    }

    private func registerDataCaches() {
        container.register(DataCache<Dashboard>.self) { _ in
            DataCache<Dashboard>()
        }
        .inObjectScope(.container)

        container.register(ImageCache.self) { _ in
            ImageCache()
        }
        .inObjectScope(.container)
    }

    private func registerRepositories() {
        container.register(DashboardRepositoryProtocol.self) { resolver in
            DashboardRepository(
                apiService: resolver.resolve(APIServiceProtocol.self)!,
                dataCache: resolver.resolve(DataCache.self)!
            )
        }
        .inObjectScope(.weak)
        container.register(ImageRepositoryProtocol.self) { resolver in
            ImageRepository(
                cache: resolver.resolve(ImageCache.self)!
            )
        }
        .inObjectScope(.weak)
    }

    private func registerUseCases() {
        container.register(DashboardUseCaseProtocol.self) { resolver in
            DashboardUseCase(
                repository: resolver.resolve(DashboardRepositoryProtocol.self)!
            )
        }
        .inObjectScope(.weak)
    }

    private func registerViewModels() {
        container.register(DashboardViewModel.self) { resolver in
            DashboardViewModel(
                dashboardUseCase: resolver.resolve(DashboardUseCaseProtocol.self)!
            )
        }
        .inObjectScope(.container)
        container.register(CachedImageViewModel.self) { resolver in
            CachedImageViewModel(
                repository: resolver.resolve(ImageRepositoryProtocol.self)!
            )
        }
        .inObjectScope(.transient)
    }

    func resolve<T>(_ type: T.Type) -> T {
        return container.resolve(type)!
    }
}
