//
//  ScrollViewViewController.swift
//  iOSAutomationDemoApp
//
//  Created by Pavel Balint on 06/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import UIKit

class ScrollViewViewController: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var dismissButton: UIButton!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet var parentView: UIView!


  @IBAction func showAlert(_ sender: Any) {
    showAlert("You've reached bottom of the scrollview!")
  }

  override func viewDidLoad() {
    scrollView.delegate = self
  }

  func showAlert(_ body: String) {
    let alertController = UIAlertController(title: "Alert!", message:
      body, preferredStyle: UIAlertControllerStyle.alert)
      alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
      self.present(alertController, animated: true, completion: nil)
  }
}
