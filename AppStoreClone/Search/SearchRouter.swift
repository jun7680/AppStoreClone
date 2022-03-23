//
//  SearchRouter.swift
//  AppStoreClone
//
//  Created by 옥인준 on 2022/03/20.
//

import RIBs

protocol SearchInteractable: Interactable,
                             SearchDetailListener {
    var router: SearchRouting? { get set }
    var listener: SearchListener? { get set }
}

protocol SearchViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchRouter: ViewableRouter<SearchInteractable, SearchViewControllable>, SearchRouting {

    private let searchDetailBuilder: SearchDetailBuildable
    private var searchDetailRouting: SearchDetailRouting?
    
    init(
        interactor: SearchInteractable,
        viewController: SearchViewControllable,
        searchDetailBuilder: SearchDetailBuildable
    ) {
        self.searchDetailBuilder = searchDetailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToDetail(_ item: Result) {
        let routing = searchDetailBuilder.build(withListener: interactor, item: item)
        searchDetailRouting = routing
        attachChild(routing)
        
        viewControllable.pushViewController(routing.viewControllable, animated: true)
    }
    
    func detachDetail() {
        guard let routing = searchDetailRouting else { return }
        detachChild(routing)
        self.searchDetailRouting = nil
    }
}
