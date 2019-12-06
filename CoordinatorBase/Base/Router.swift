//
//  Router.swift
//  RecipeApp
//
//  Created by Wenzhong Zheng on 2019-07-20.
//  Copyright © 2019 ZzzKit. All rights reserved.
//

import Foundation
import UIKit

protocol Router: Presentable {
  var rootViewContoller: UIViewController? { get }
  
  func present(_ module: Presentable)
  func present(_ module: Presentable, animated: Bool)
  
  func push(_ module: Presentable)
  func push(_ module: Presentable, hideBottomBar: Bool)
  func push(_ module: Presentable, animated: Bool)
  func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?)
  func push(_ module: Presentable, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)
  
  func popModule()
  func popModule(animated: Bool)
  
  func dismissModule()
  func dismissModule(animated: Bool, completion: (() -> Void)?)
  
  func setRootModule(_ module: Presentable)
  func setRootModule(_ module: Presentable, hideBar: Bool)
  
  func popToRootModule(animated: Bool)
}
