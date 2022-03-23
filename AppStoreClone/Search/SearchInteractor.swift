//
//  SearchInteractor.swift
//  AppStoreClone
//
//  Created by 옥인준 on 2022/03/20.
//

import RIBs
import RxSwift

protocol SearchRouting: ViewableRouting {
    func routeToDetail(_ item: Result)
    func detachDetail()
}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
    func searchResultUpdate(_ result: [Result])
}

protocol SearchListener: AnyObject {
}

final class SearchInteractor: PresentableInteractor<SearchPresentable>, SearchInteractable, SearchPresentableListener {

    weak var router: SearchRouting?
    weak var listener: SearchListener?
    
    private var searchTerm = String()
    private var searchResult = [Result]()
    private let limit = 25
    private var resultCount = 0
    private var isLoading = false

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
        searchTerm = term
        searchResult.removeAll()
        Service.shared.search(term: term) { [weak self] result, error in            
            guard let self = self else { return }
            self.resultCount = result?.resultCount ?? 0
            if let result = result?.results {
                self.searchResult = result
                self.presenter.searchResultUpdate(result)
            }
        }
    }
    
    func searchWithPagination(offset: Int) {
        guard !isLoading else { return }
        isLoading = true
        Service.shared.search(term: searchTerm, offset: offset) { [weak self] result, error in
            guard let self = self else { return }
            guard let result = result else { return }
            let resultItem = result.results
            
            self.resultCount += result.resultCount
            
            self.searchResult.append(contentsOf: resultItem)
            self.presenter.searchResultUpdate(self.searchResult)
            self.isLoading = false
            
        }
    }
    
    func goToDetail(_ item: Result) {
        router?.routeToDetail(item)
    }
    
    func shutdown() {
        router?.detachDetail()
    }
}
