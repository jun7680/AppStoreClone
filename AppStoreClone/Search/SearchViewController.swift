//
//  SearchViewController.swift
//  AppStoreClone
//
//  Created by 옥인준 on 2022/03/20.
//

import RIBs
import RxSwift
import RxCocoa
import RxRelay
import UIKit

protocol SearchPresentableListener: AnyObject {
    func search(term: String?)
}

final class SearchViewController: UIViewController, SearchPresentable, SearchViewControllable {
    
    var disposeBag = DisposeBag()
    weak var listener: SearchPresentableListener?
    private var resultCount = 0
    private var result = [Result]()
    @IBOutlet weak var searchColletionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeUI()
    }
    
    private func setupNavigation() {
        navigationItem.title = "검색"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func subscribeUI() {
        searchBar.rx.textDidBeginEditing
            .asDriver()
            .drive(with: self) { owner, _ in
//                owner.cancelButton.isHidden = false
//                UIView.transition(with: owner.navigationController!.navigationBar, duration: 0.5, options: .transitionCrossDissolve, animations: {
//                    owner.navigationController?.navigationBar.prefersLargeTitles = false
//                })
            }.disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .asDriver()
            .drive(with: self) { owner, _ in
                owner.listener?.search(term: owner.searchBar.text)
            }.disposed(by: disposeBag)
    }
    
    func searchResultUpdate(_ result: SearchResultDTO?) {
        
        if let result = result?.results {
            self.result = result
            DispatchQueue.main.async {
                self.searchColletionView.reloadData()                
            }
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchResultCell else { return .init() }
        cell.configure(from: result[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 0.7)
    }
}
