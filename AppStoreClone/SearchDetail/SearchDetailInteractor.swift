//
//  SearchDetailInteractor.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/22.
//

import RIBs
import RxSwift

protocol SearchDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchDetailPresentable: Presentable {
    var listener: SearchDetailPresentableListener? { get set }
    func setDetailItem(item: Result)
}

protocol SearchDetailListener: AnyObject {
    func shutdown()
}

final class SearchDetailInteractor: PresentableInteractor<SearchDetailPresentable>, SearchDetailInteractable, SearchDetailPresentableListener {

    weak var router: SearchDetailRouting?
    weak var listener: SearchDetailListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SearchDetailPresentable, item: Result) {
        super.init(presenter: presenter)
        presenter.listener = self
        presenter.setDetailItem(item: item)        
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func shutdown() {
        listener?.shutdown()
    }
}
