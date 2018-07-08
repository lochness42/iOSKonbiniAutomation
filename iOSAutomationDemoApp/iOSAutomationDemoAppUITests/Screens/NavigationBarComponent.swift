//
//  NavigationBarComponent.swift
//  iOSAutomationDemoAppUITests
//
//  Created by Pavel Balint on 08/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers
import iOSKonbiniAutomation

class NavigationBarComponent: UITestScreen {

  public func navigateBack() {
    Tap(on: self.app.navigationBars.buttons.element(boundBy: 0))
  }

  public func save() {
    Tap(on: self.app.navigationBars.buttons.matching(identifier: "save").element(boundBy: 0))
  }

  public func cancel() {
    Tap(on: self.app.navigationBars.buttons.matching(identifier: "cancel").element(boundBy: 0))
  }

}
