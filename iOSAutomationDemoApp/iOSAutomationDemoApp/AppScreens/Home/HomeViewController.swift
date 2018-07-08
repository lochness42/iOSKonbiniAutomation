//
//  HomeViewController.swift
//  iOSAutomationDemoApp
//
//  Created by Pavel Balint on 06/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  enum HomeNavigation {
    case DatePicker
    case ScrollView
    case DelayWait
    case Map

    var tableIdentifier: String {
      switch self {
      case .DatePicker:
        return NSLocalizedString("DatePicker", comment: "Date picker screen navigation cell title")
      case .ScrollView:
        return NSLocalizedString("ScrollView", comment: "ScrollView screen navigation cell title")
      case .DelayWait:
        return NSLocalizedString("DelayWait", comment: "DelayWait screen navigation cell title")
      case .Map:
        return NSLocalizedString("Map", comment: "Map screen navigation cell title")
      }
    }
    var segueIdentifier: String {
      switch self {
      case .DatePicker:
        return "DatePicker"
      case .ScrollView:
        return "ScrollView"
      case .DelayWait:
        return "DelayWait"
      case .Map:
        return "Map"
      }
    }
  }

  @IBOutlet weak var homeTableView: UITableView!
  @IBOutlet weak var homeTableViewCell: UITableViewCell!

  var homeNavigation: [HomeNavigation] = [.DatePicker, .ScrollView, .DelayWait, .Map]

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return homeNavigation.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
    cell.textLabel?.text = homeNavigation[indexPath.row].tableIdentifier
    cell.accessibilityIdentifier = "home.table.\(homeNavigation[indexPath.row].segueIdentifier.lowercased())"
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: homeNavigation[indexPath.row].segueIdentifier, sender: self)
  }
}
