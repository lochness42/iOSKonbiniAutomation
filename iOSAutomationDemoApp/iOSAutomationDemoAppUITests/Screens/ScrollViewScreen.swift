//
//  ScrollViewScreen.swift
//  iOSAutomationDemoAppUITests
//
//  Created by Pavel Balint on 08/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers
import iOSKonbiniAutomation

class ScrollView: UITestScreen {
  override var screenIdentifierPrefix: String {
    return "scrollview"
  }

  public var scrollView: XCUIElement {
    return app.descendants(ofType: .scrollView, which: [.equals(.identifier, screenIdentifierPrefix)]).element(boundBy: 0)
  }

  public var topLabel: XCUIElement {
    return scrollView.descendants(ofType: .staticText, which: [.endsWith(.identifier, ".top")]).element(boundBy: 0)
  }

  public var middleLabel: XCUIElement {
    return scrollView.descendants(ofType: .staticText,which: [.endsWith(.identifier, ".middle")]).element(boundBy: 0)
  }

  public var showAlertButton: XCUIElement {
    return scrollView.descendants(ofType: .button, which: [.endsWith(.identifier, ".showAlert")]).element(boundBy: 0)
  }

  public var alert: XCUIElement {
    return app.alerts["Alert!"]
  }

  public func dismissAlert() {
    alert.buttons["Dismiss"].tap()
  }

  required init() {
    super.init()
    setScreenTraitStrategy(.specificElements([scrollView]))
    connectTo(screen: Home.self, transition: screen(NavigationBarComponent.self).navigateBack)
  }
}
