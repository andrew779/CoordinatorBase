//
//  Presentable.swift
//  RecipeApp
//
//  Created by Wenzhong Zheng on 2019-07-20.
//  Copyright © 2019 ZzzKit. All rights reserved.
//

import UIKit

protocol Presentable {
  func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
  func toPresent() -> UIViewController? {
    return self
  }
}
