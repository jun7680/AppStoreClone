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
}

final class SearchViewController: UIViewController, SearchPresentable, SearchViewControllable {
    var disposeBag = DisposeBag()
    weak var listener: SearchPresentableListener?
    
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
                owner.cancelButton.isHidden = false
                UIView.transition(with: owner.navigationController!.navigationBar, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    owner.navigationController?.navigationBar.prefersLargeTitles = false
                })
                

            }.disposed(by: disposeBag)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchResultCell else { return .init() }
        
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
