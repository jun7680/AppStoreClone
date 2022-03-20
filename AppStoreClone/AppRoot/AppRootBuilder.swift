//
//  AppRootBuilder.swift
//  AppStoreClone
//
//  Created by 옥인준 on 2022/03/20.
//

import RIBs

protocol AppRootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppRootComponent: Component<AppRootDependency>, SearchDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {

    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = AppRootComponent(dependency: dependency)
        let viewController = RootTabBarController()
        let interactor = AppRootInteractor(presenter: viewController)
        
        let search = SearchBuilder(dependency: component)
        let router = AppRootRouter(
            interactor: interactor,
            viewController: viewController,
            searchBuildable: search
        )
        
        return router
    }
}
