//
//  AppDelegate.swift
//  AppStoreClone
//
//  Created by 옥인준 on 2022/03/20.
//

import UIKit
import RIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.backgroundColor = .white
        let router = AppRootBuilder(dependency: AppComponent()).build()
        self.launchRouter = router
        launchRouter?.launch(from: window)
        
        return true
    }

}

