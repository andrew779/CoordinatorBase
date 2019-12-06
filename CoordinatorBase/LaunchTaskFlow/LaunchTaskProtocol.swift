//
//  LaunchTaskProtocol.swift
//  CoordinatorBase
//
//  Created by wenzhong zheng on 2019-12-06.
//  Copyright © 2019 wenzhong zheng. All rights reserved.
//

import Foundation

/// The available resolutions for a failed task
enum LaunchTaskResolution {
  /// Ingore the task failure, and move to the next step
  case `continue`
  /// Alert the user with a popup, with one action ("OK") for them to tap, and continue to the next
  /// step
  case alertAndContinue(title: String, message: String)
  /// Alert the user with a popup, with one action ("Retry") for them to tap, which will perform the
  /// same task again
  case alertAndRetry(title: String, message: String)
  /// A no connection viewController will be presented, with a Retry action button to checking reachability of the device
  /// Tap on Retry button will dismiss noConnectionViewController when network connection is recovered
  case noConnectionAndRetry
}

/// The available result set for a launch task
enum LaunchTaskResult {
  /// The task finished successfully
  case success
  /// The task failed and wants a given resolution
  case failure(LaunchTaskResolution)
}

protocol LaunchTaskDelegate: class {
  /// Tells the launch task to begin whatever it needs to do
  func startTask()
  /// A block that should be executed by the conforming object whenever its task is completed.
  ///
  /// This gives asyncronous tasks a chance to finish without moving onto the next step, or even
  /// allow UI that requires an action (i.e. Onboarding) to finish and moe to the next task
  ///
  /// - note: This block must be called on the main thread, failure to do so will cause a
  /// `fatalError`
  var taskCompleted: ((_ result: LaunchTaskResult) -> Void)? { get set }
}
