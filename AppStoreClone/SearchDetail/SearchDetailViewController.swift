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
    func shutdown()
}

final class SearchDetailViewController: UIViewController,
                                        SearchDetailPresentable,
                                        SearchDetailViewControllable {
    
    weak var listener: SearchDetailPresentableListener?
    var disposeBag = DisposeBag()
    @IBOutlet weak var collectionView: UICollectionView!
    private var detailItem: Result? = nil
    var isTapMoreButton = false
    var height = CGFloat(200)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupNavigation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        listener?.shutdown()
    }
    func configureCollectionView() {
        collectionView.collectionViewLayout = createCollectionViewLayout()
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {[weak self] sectionNumber, env -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                      widthDimension: .fractionalWidth(1.0),
                      heightDimension: .fractionalHeight(0.78)))
                item.contentInsets = NSDirectionalEdgeInsets(
                  top: 2,
                  leading: 2,
                  bottom: 2,
                  trailing: 2)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200)), subitems: [item])
                group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
                return section
            } else if sectionNumber == 1 {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                      widthDimension: .fractionalWidth(1.0),
                      heightDimension: .fractionalHeight(0.78)))
                item.contentInsets = NSDirectionalEdgeInsets(
                  top: 2,
                  leading: 2,
                  bottom: 2,
                  trailing: 2)
                
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(self?.height ?? 0)), subitems: [item])
            
                group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)
                
                return section
            } else {
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(widthDimension: .fractionalWidth(1),
                                      heightDimension: .fractionalHeight(2.5)
                                     )
                )
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                      heightDimension: .estimated(150)),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
                return section
            }
        }
        
        return layout
    }
    func setDetailItem(item: Result) {
        detailItem = item
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationItem.largeTitleDisplayMode = .never
        
    }
}

extension SearchDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(section)
        if section == 0 || section == 1 {
            return 1
        } else {
            return detailItem?.screenshotUrls.count ?? 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("section")
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath)
                    as? TitleCell
            else { return .init() }
            if let detailItem = detailItem {
                cell.configure(from: detailItem)
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionCell", for: indexPath)
                    as? DescriptionCell
            else { return .init() }
            if let detailItem = detailItem {
                cell.configure(from: detailItem, isTapMoreButton: isTapMoreButton) { [weak self] in
                    self?.isTapMoreButton = true
                    collectionView.reloadItems(at: [indexPath])
                }
                if isTapMoreButton {
                    height = cell.contentView.frame.height + cell.labelHeight
                }
                collectionView.collectionViewLayout.invalidateLayout()
            }
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenShotCell", for: indexPath)
                    as? ScreenShotCell
            else { return .init() }
            if let urls = detailItem?.screenshotUrls {
                cell.setScreenShot(from: urls[indexPath.row])
            }
            return cell
        default: return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath)
            
            return headerView
        default:
            assert(false, "error")
        }
    }
}
