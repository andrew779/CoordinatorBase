//
//  Coordinator.swift
//  RecipeApp
//
//  Created by Wenzhong Zheng on 2019-07-20.
//  Copyright © 2019 ZzzKit. All rights reserved.
//

import Foundation

protocol Coordinator: class {
  var childCoordinators: [Coordinator] { get set }
  
  func start()
}

extension Coordinator {
  /// adding dependency in order to hold coordinator reference so it won't be deallocated when we need it
  func addDependency(_ coordinator: Coordinator) {
    guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
    childCoordinators.append(coordinator)
  }
  
  /// recursively remove dependency so it can be deallocated when we don't need it
  func removeDependency(_ coordinator: Coordinator?) {
    guard !childCoordinators.isEmpty, let coordinator = coordinator else { return }
    
    if !coordinator.childCoordinators.isEmpty {
      coordinator.childCoordinators
        .filter { $0 !== coordinator }
        .forEach { coordinator.removeDependency($0) }
    }
    
    for (index, element) in childCoordinators.enumerated() where element === coordinator {
      childCoordinators.remove(at: index)
      break
    }
  }
}
