//
//  AppComponent.swift
//  AppStoreClone
//
//  Created by 옥인준 on 2022/03/20.
//

import RIBs

final class AppComponent: Component<EmptyDependency>, AppRootDependency {
  
  init() {
    super.init(dependency: EmptyComponent())
  }
  
}
