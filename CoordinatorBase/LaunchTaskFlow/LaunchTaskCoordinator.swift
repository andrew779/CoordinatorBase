//
//  LaunchTaskCoordinator.swift
//  CoordinatorBase
//
//  Created by wenzhong zheng on 2019-12-06.
//  Copyright © 2019 wenzhong zheng. All rights reserved.
//

import Foundation

class LaunchTaskCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  var flowFinished: ((Coordinator) -> Void)?
  
  private let router: Router
  
  private enum Step: Int {
    case config
    case versionCheck
    
    static let appConfigTask = AppConfigTask()
    static let versionCheckTask = VersionCheckTask()
    
    static var first: Step? {
      return Step(rawValue: 0)
    }
    
    var next: Step? {
      return Step(rawValue: rawValue + 1)
    }
    
    var task: LaunchTaskDelegate {
      switch self {
      case .config:
        return type(of: self).appConfigTask
      case .versionCheck:
        return type(of: self).versionCheckTask
      }
    }
  }
  
  //test, should remove later
  var module: ViewController
  
  init(router: Router) {
    self.router = router
    self.module = ViewController()
  }
  
  deinit {
    print("LaunchTaskCoordinator deinit")
  }
  
  
  func start() {
    self.router.setRootModule(module, hideBar: true)
    performTask(for: Step.first)
  }
  
  private func performTask(for step: Step?) {
    guard let step = step else {
      flowFinished?(self)
      return
    }
    
    switch step {
    case .config:
      break
    case .versionCheck:
      break
    }
    
    step.task.taskCompleted = { [weak self] result in
      self?.handleTaskCompletion(step, result: result)
    }
    
    step.task.startTask()
  }
  
  private func handleTaskCompletion(_ step: Step, result: LaunchTaskResult) {
    assert(Thread.isMainThread, "This must be called from the main thread")
    
    switch result {
    case .success:
      performTask(for: step.next)
    default:
      break
    }
  }
}
