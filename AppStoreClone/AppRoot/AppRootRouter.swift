//
//  AppRootRouter.swift
//  AppStoreClone
//
//  Created by 옥인준 on 2022/03/20.
//

import RIBs

protocol AppRootInteractable: Interactable, SearchListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func setViewControllers(_ viewControllers: [ViewControllable])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {

    private let searchBuildable: SearchBuildable
    private var searchRouter: SearchRouting?
    
    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        searchBuildable: SearchBuildable
    ) {
        self.searchBuildable = searchBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension AppRootRouter {
    func attachTabs() {
        let searchRouting = searchBuildable.build(withListener: interactor)
        
        attachChild(searchRouting)
        
        let viewControllers = [
            NavigationControllerable(root: searchRouting.viewControllable)
        ]
        
        viewController.setViewControllers(viewControllers)
    }
}
