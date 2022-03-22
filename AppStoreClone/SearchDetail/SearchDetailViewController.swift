//
//  SearchDetailViewController.swift
//  AppStoreClone
//
//  Created by injun on 2022/03/22.
//

import RIBs
import RxSwift
import UIKit

protocol SearchDetailPresentableListener: AnyObject {
    
}

final class SearchDetailViewController: UIViewController, SearchDetailPresentable, SearchDetailViewControllable {

    weak var listener: SearchDetailPresentableListener?
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var detailItem: Result? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setDetailItem(item: Result) {
        detailItem = item
    }
}

extension SearchDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(section)
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath)
                as? TitleCell
        else { return .init() }
        if let detailItem = detailItem {
            cell.configure(from: detailItem)
        }
        return cell
    }
}

extension SearchDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 150)
    }
}
