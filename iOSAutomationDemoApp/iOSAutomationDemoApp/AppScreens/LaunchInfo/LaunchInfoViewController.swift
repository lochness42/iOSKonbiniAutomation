//
//  LaunchInfoViewController.swift
//  iOSAutomationDemoApp
//
//  Created by Pavel Balint on 08/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import UIKit

class LaunchInfoViewController: UIViewController {

  @IBAction func showEnvironmentSettings(_ sender: Any) {
    let environment: [String: String] = ProcessInfo.processInfo.environment.filter { (key, value) in return key.hasPrefix("test_environment_")}
    showAlert(environment.debugDescription)
  }

  
  @IBAction func showArgumentsSettings(_ sender: Any) {
    let arguments: [String] = ProcessInfo.processInfo.arguments.filter { return $0.hasPrefix("test_argument_")}
    showAlert(arguments.debugDescription)
  }
  override func viewDidLoad() {

  }

  func showAlert(_ body: String) {
    let alertController = UIAlertController(title: "Settings", message:
      body, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
    self.present(alertController, animated: true, completion: nil)
  }
}
