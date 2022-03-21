//
//  SearchInteractor.swift
//  AppStoreClone
//
//  Created by 옥인준 on 2022/03/20.
//

import RIBs
import RxSwift

protocol SearchRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
    func searchResultUpdate(_ result: SearchResultDTO?)
}

protocol SearchListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchInteractor: PresentableInteractor<SearchPresentable>, SearchInteractable, SearchPresentableListener {

    weak var router: SearchRouting?
    weak var listener: SearchListener?

    override init(presenter: SearchPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        search(term: "카카오")
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func search(term: String?) {
        guard let term = term else { return }
        Service.shared.search(term: term) { [weak self] result, error in
            print(error)
            self?.presenter.searchResultUpdate(result)
        }
    }
}
