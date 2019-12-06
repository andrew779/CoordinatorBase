//
//  VersionCheckTask.swift
//  CoordinatorBase
//
//  Created by wenzhong zheng on 2019-12-06.
//  Copyright © 2019 wenzhong zheng. All rights reserved.
//

import Foundation

class VersionCheckTask: LaunchTaskDelegate {
  func startTask() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      self.taskCompleted?(.success)
    }
  }
  
  var taskCompleted: ((LaunchTaskResult) -> Void)?
  
  
}
