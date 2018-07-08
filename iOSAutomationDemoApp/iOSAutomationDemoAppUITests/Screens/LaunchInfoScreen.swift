//
//  LaunchInfoScreen.swift
//  iOSAutomationDemoAppUITests
//
//  Created by Pavel Balint on 08/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers
import iOSKonbiniAutomation

class LaunchInfo: UITestScreen {
  override var screenIdentifierPrefix: String {
    return "launchInfo"
  }

  public var launchInfoView: XCUIElement {
    return app.descendants(ofType: .other, which: [.equals(.identifier, screenIdentifierPrefix)]).element(boundBy: 0)
  }

  public var launchArgumentsButton: XCUIElement {
    return launchInfoView.descendants(ofType: .button, which: [.endsWith(.identifier, ".arguments")]).element(boundBy: 0)
  }

  public var launchEnvironmentButton: XCUIElement {
    return launchInfoView.descendants(ofType: .button, which: [.endsWith(.identifier, ".environment")]).element(boundBy: 0)
  }

  public var alert: XCUIElement {
    return app.alerts["Settings"]
  }

  public var alertText: XCUIElement {
    return alert.staticTexts.element(boundBy: 1)
  }

  public func dismissAlert() {
    alert.buttons["Dismiss"].tap()
  }

  public func verifyLaunchArguments(_ arguments: [String]) -> Bool {
    var allFound = true
    for argument in arguments {
      allFound = TryToWaitFor(element: alertText, to: [.contains(.label, argument)], atMost: 1)
    }
    return allFound
  }

  public func verifyLaunchEnvironment(_ environment: [String: String], prefix: String? = nil) -> Bool {
    var allFound = true
    for (key, value) in environment {
      let pairString = ".*\"\(prefix ?? "")\(key)\": \"\(value)\".*"
      allFound = TryToWaitFor(element: alertText, to: [.matchesWithRegex(.label, pairString)], atMost: 1)
    }
    return allFound
  }

  required init() {
    super.init()
    setScreenTraitStrategy(.specificElements([launchInfoView]))
    connectTo(screen: Home.self, transition: screen(NavigationBarComponent.self).navigateBack)
  }
}
