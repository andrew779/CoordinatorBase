//
//  RouterImp.swift
//  RecipeApp
//
//  Created by Wenzhong Zheng on 2019-07-20.
//  Copyright © 2019 ZzzKit. All rights reserved.
//

import UIKit

/// A concrate router implementation
final class RouterImp: Router {
  var rootViewContoller: UIViewController? {
    return navigationController?.viewControllers.first
  }
  
  
  typealias Completion = () -> Void
  private weak var navigationController: UINavigationController?
  
  /// this completions var is to hold completion reference when any showed UIViewController needed and use for helping coordinator manage it's lifecycle
  private var completions: [UIViewController: Completion] = [:]
  
  init(rootController: UINavigationController) {
    self.navigationController = rootController
  }
  
  func toPresent() -> UIViewController? {
    return navigationController 
  }
  
  func present(_ module: Presentable) {
    present(module, animated: true)
  }
  
  func present(_ module: Presentable, animated: Bool) {
    guard let controller = module.toPresent() else { return }
    navigationController?.present(controller, animated: animated, completion: nil)
  }
  
  func push(_ module: Presentable) {
    push(module, animated: true)
  }
  
  func push(_ module: Presentable, hideBottomBar: Bool) {
    push(module, animated: true, hideBottomBar: hideBottomBar, completion: nil)
  }
  
  func push(_ module: Presentable, animated: Bool) {
    push(module, animated: animated, completion: nil)
  }
  
  func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?) {
    push(module, animated: animated, hideBottomBar: false, completion: completion)
  }
  
  func push(_ module: Presentable, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?) {
    guard let controller = module.toPresent(), (controller is UINavigationController == false) else {
      assertionFailure("Fail to push UINavigationController.")
      return
    }
    
    if let completion = completion {
      completions[controller] = completion
    }
    
    controller.hidesBottomBarWhenPushed = hideBottomBar
    navigationController?.pushViewController(controller, animated: animated)
  }
  
  func popModule() {
    popModule(animated: true)
  }
  
  func popModule(animated: Bool) {
    if let contoller = navigationController?.popViewController(animated: animated) {
      runCompletion(for: contoller)
    }
  }
  
  func dismissModule() {
    dismissModule(animated: true, completion: nil)
  }
  
  func dismissModule(animated: Bool, completion: (() -> Void)?) {
    navigationController?.dismiss(animated: animated, completion: completion)
  }
  
  func setRootModule(_ module: Presentable) {
    setRootModule(module, hideBar: false)
  }
  
  func setRootModule(_ module: Presentable, hideBar: Bool) {
    guard let controller = module.toPresent() else { return }
    navigationController?.setViewControllers([controller], animated: false)
    navigationController?.isNavigationBarHidden = hideBar
  }
  
  func popToRootModule(animated: Bool) {
    if let controllers = navigationController?.popToRootViewController(animated: animated) {
      controllers.forEach { runCompletion(for: $0) }
    }
  }
  
  private func runCompletion(for controller: UIViewController) {
    guard let completion = completions[controller] else { return }
    completion()
    completions.removeValue(forKey: controller)
  }
}
