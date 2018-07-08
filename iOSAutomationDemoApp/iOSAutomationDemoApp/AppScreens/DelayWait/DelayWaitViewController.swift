//
//  DelayWaitViewController.swift
//  iOSAutomationDemoApp
//
//  Created by Pavel Balint on 06/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import UIKit

class DelayWaitViewController: UIViewController {
  @IBOutlet weak var actionButton: UIButton!
  @IBOutlet weak var helloLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  override func viewDidLoad() {
    helloLabel.isHidden = true
  }

  @IBAction func triggerAction(_ sender: Any) {
    actionButton.isHidden = true
    helloLabel.isHidden = true
    activityIndicator.isHidden = false
    activityIndicator.startAnimating()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.actionButton.isHidden = false
      self.activityIndicator.stopAnimating()
      self.helloLabel.isHidden = false
    }
  }
}
