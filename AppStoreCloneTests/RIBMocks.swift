//
//  RIBMocks.swift
//  AppStoreCloneTests
//
//  Created by injun on 2022/03/23.
//

import UIKit
import RIBs
import RxSwift
@testable import AppStoreClone

class ViewableRoutingMock: RoutingMock, ViewableRouting {
    var viewControllableSetCallCount = 0
    var viewControllable: ViewControllable { didSet { viewControllableSetCallCount += 1 } }
    
    required init(interactable: Interactable, viewControllable: ViewControllable) {
        self.viewControllable = viewControllable
        
        super.init(interactable: interactable)
    }
}

class RoutingMock: Routing {
    var interactableSetCallCount = 0
    var interactable: Interactable { didSet { interactableSetCallCount += 1} }
    
    var childrenSetCallCount = 0
    var children: [Routing] = [Routing]() {
        didSet { childrenSetCallCount += 1}
    }
    
    var loadCallCount = 0
    func load() {
        loadCallCount += 1
    }
    
    var attachChildCallCount = 0
    var attachChildChild: Routing?
    func attachChild(_ child: Routing) {
        attachChildCallCount += 1
        attachChildChild = child
    }
    
    var detachChildCallCount = 0
    var detachChildChild: Routing?
    func detachChild(_ child: Routing) {
        detachChildCallCount += 1
        detachChildChild = child
    }
    
    var lifecycleSubjectSetCallCount = 0
    var lifecycleSubject = PublishSubject<RouterLifecycle>() {
        didSet { lifecycleSubjectSetCallCount += 1 }
    }
    var lifecycle: Observable<RouterLifecycle> { return lifecycleSubject }
    
    init(interactable: Interactable) {
        self.interactable = interactable
    }
}

class InteractableMock: Interactable {
    var activateCallCount = 0
    func activate() {
        activateCallCount += 1
    }
    
    var deactiveCallCount = 0
    func deactivate() {
        deactiveCallCount += 1
    }
    
    var isActiveCallCount = 0
    var isActive: Bool = false { didSet { isActiveCallCount += 1}}
    
    var isActiveStreamSubject: PublishSubject<Bool> = PublishSubject<Bool>() {
        didSet { isActiveStreamSubjectSetCallCount += 1 }
    }
    var isActiveStreamSubjectSetCallCount = 0
    var isActiveStream: Observable<Bool> { return isActiveStreamSubject }
}
