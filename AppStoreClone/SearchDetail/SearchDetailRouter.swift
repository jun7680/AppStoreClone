//
//  SearchDetailRouter.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/22.
//

import RIBs

protocol SearchDetailInteractable: Interactable {
    var router: SearchDetailRouting? { get set }
    var listener: SearchDetailListener? { get set }
}

protocol SearchDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchDetailRouter: ViewableRouter<SearchDetailInteractable, SearchDetailViewControllable>, SearchDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchDetailInteractable, viewController: SearchDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
