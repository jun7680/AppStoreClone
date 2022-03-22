//
//  SearchDetailBuilder.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/22.
//

import RIBs
import UIKit

protocol SearchDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchDetailComponent: Component<SearchDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchDetailBuildable: Buildable {
    func build(withListener listener: SearchDetailListener, item: Result) -> SearchDetailRouting
}

final class SearchDetailBuilder: Builder<SearchDetailDependency>, SearchDetailBuildable {

    override init(dependency: SearchDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchDetailListener, item: Result) -> SearchDetailRouting {
        let component = SearchDetailComponent(dependency: dependency)
        let storyBoard = UIStoryboard(name: "SearchDetailViewController", bundle: nil)
        let viewController = storyBoard.instantiateViewController(
            withIdentifier: "SearchDetailViewController"
        ) as! SearchDetailViewController
        let interactor = SearchDetailInteractor(presenter: viewController, item: item)
        interactor.listener = listener
        return SearchDetailRouter(interactor: interactor, viewController: viewController)
    }
}
