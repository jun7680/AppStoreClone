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
    func searchWithPagination(offset: Int)
    
    //select
    func goToDetail(_ item: Result)
}

final class SearchViewController: UIViewController, SearchPresentable, SearchViewControllable {
    
    var disposeBag = DisposeBag()
    weak var listener: SearchPresentableListener?
    private var resultCount = 0
    private var result = [Result]()
    @IBOutlet weak var searchColletionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cancelButton: UIButton!    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        subscribeUI()
    }
    
    private func setupNavigation() {
        navigationItem.title = "검색"
        navigationItem.largeTitleDisplayMode = .always
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
                UIView.animate(withDuration: 0.5, animations: {
                    owner.cancelButton.isHidden = false
                    owner.navigationController?.navigationBar.isHidden = true
                    owner.navigationItem.largeTitleDisplayMode = .never
                })
            }.disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                owner.searchBar.text = nil
                owner.result.removeAll()
                UIView.animate(withDuration: 0.5, animations: {
                    owner.searchColletionView.reloadData()
                    owner.cancelButton.isHidden = true
                    owner.navigationController?.navigationBar.isHidden = false
                    owner.navigationItem.largeTitleDisplayMode = .always
                    owner.searchBar.endEditing(true)
                })
                
            }.disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .asDriver()
            .drive(with: self) { owner, _ in
                owner.activityIndicator.startAnimating()
                owner.searchBar.endEditing(true)
                owner.listener?.search(term: owner.searchBar.text)
            }.disposed(by: disposeBag)
    }
    
    func searchResultUpdate(_ result: [Result]) {
        self.result = result
        DispatchQueue.main.async {
            self.searchColletionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func startSearch() {
        activityIndicator.startAnimating()
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == result.count - 2 {
            listener?.searchWithPagination(offset: result.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.endEditing(true)
        listener?.goToDetail(result[indexPath.row])        
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 0.7)
    }
}
