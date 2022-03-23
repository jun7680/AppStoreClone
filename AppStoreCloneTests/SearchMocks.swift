//
//  SearchMocks.swift
//  AppStoreCloneTests
//
//  Created by injun on 2022/03/23.
//

import Foundation
@testable import AppStoreClone

final class SearchPresenterMock: SearchPresentable {
    var listener: SearchPresentableListener?
    
    var callCount = 0
    var resultCount = 0
    var appTitle: String?
    func searchResultUpdate(_ result: [Result]) {
        callCount += 1
        resultCount += result.count
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
    
}

final class SearchInteractableMock: InteractableMock, SearchInteractable {
    var listener: SearchListener?
    var router: SearchRouting?
}

final class SearchViewControllableMock: SearchViewControllable { }
