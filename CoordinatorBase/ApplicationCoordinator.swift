//
//  ApplicationCoordinator.swift
//  CoordinatorBase
//
//  Created by wenzhong zheng on 2019-12-06.
//  Copyright © 2019 wenzhong zheng. All rights reserved.
//

import Foundation

class ApplicationCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  
  private let router: Router
  
  init(router: Router) {
    self.router = router
  }
  
  func start() {
    runLaunchTaskFlow()
  }
  
  /// LaunchCoordinator --> OnboardingCoordinator
  private func runLaunchTaskFlow() {
    let launchCoordinator = LaunchTaskCoordinator(router: self.router)
    launchCoordinator.flowFinished = { coordinator in
      self.removeDependency(coordinator)
      self.runOnboardingFlow()
    }
    addDependency(launchCoordinator)
    launchCoordinator.start()
  }
  
  /// OnboardingCoordinator --> MainCooridnator
  private func runOnboardingFlow() {
  }
  
  private func runMainFlow() {
  }
}
