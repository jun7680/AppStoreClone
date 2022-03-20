//
//  AppRootViewController.swift
//  AppStoreClone
//
//  Created by 옥인준 on 2022/03/20.
//

import RIBs
import RxSwift
import UIKit

protocol AppRootPresentableListener: AnyObject { }

final class RootTabBarController: UITabBarController, AppRootPresentable, AppRootViewControllable {
    weak var listener: AppRootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = true
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        
    }
    
    func setViewControllers(_ viewControllers: [ViewControllable]) {
        super.setViewControllers(viewControllers.map(\.uiviewController), animated: false)
    }
    
}
