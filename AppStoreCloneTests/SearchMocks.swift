//
//  SearchMocks.swift
//  AppStoreCloneTests
//
//  Created by injun on 2022/03/23.
//

import Foundation
import RIBs
@testable import AppStoreClone
import UIKit

final class SearchPresenterMock: SearchPresentable {
    var listener: SearchPresentableListener?
    
    var callCount = 0
    var resultCount = 0
    func searchResultUpdate(_ result: [Result]) {
        callCount += 1
        resultCount += result.count
    }
    
    var loadingCallCount = 0
    func startSearch() {
        callCount += 1
    }
}

final class SearchListenerMock: SearchListener { }

final class SearchBuildableMock: SearchBuildable {
    var buildCallCount = 0
    var listener: SearchListener?
    func build(withListener listener: SearchListener) -> ViewableRouting {
        buildCallCount += 1
        self.listener = listener
        
        return SearchRoutingMock(
            interactable: SearchInteractableMock(),
            viewControllable: SearchViewControllableMock()
        )
    }
}

final class SearchRoutingMock: ViewableRoutingMock, SearchRouting {
    var routeToDetailCallCount = 0
    func routeToDetail(_ item: Result) {
        routeToDetailCallCount += 1
    }
    
    var detachCallCount = 0
    func detachDetail() {
        detachCallCount += 1
    }
    
    
}

final class SearchInteractableMock: InteractableMock, SearchInteractable {
    var shutDownCallCount = 0
    func shutdown() {
        shutDownCallCount += 1
    }
    
    var listener: SearchListener?
    var router: SearchRouting?
}

final class SearchViewControllableMock: SearchViewControllable {
    var uiviewController: UIViewController = UIViewController(nibName: nil, bundle: nil)
}
