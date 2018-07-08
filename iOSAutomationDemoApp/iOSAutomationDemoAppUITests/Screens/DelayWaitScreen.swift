//
//  DelayWaitScreen.swift
//  iOSAutomationDemoAppUITests
//
//  Created by Pavel Balint on 08/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers
import iOSKonbiniAutomation

class DelayWait: UITestScreen {
  override var screenIdentifierPrefix: String {
    return "delayWait"
  }

  public var delayWaitView: XCUIElement {
    return app.descendants(ofType: .other, which: [.equals(.identifier, screenIdentifierPrefix)]).element(boundBy: 0)
  }

  public var helloLabel: XCUIElement {
    return delayWaitView.descendants(ofType: .staticText, which: [.endsWith(.identifier, ".hello")]).element(boundBy: 0)
  }

  public var showButton: XCUIElement {
    return delayWaitView.descendants(ofType: .button, which: [.endsWith(.identifier, ".show")]).element(boundBy: 0)
  }

  public var activityIndicator: XCUIElement {
    return delayWaitView.descendants(matching: .activityIndicator).element(boundBy: 0)
  }

  required init() {
    super.init()
    setScreenTraitStrategy(.anyWithScreenIdentifierPrefix(elementType: .other, identifierPrefix: screenIdentifierPrefix))
    connectTo(screen: Home.self, transition: screen(NavigationBarComponent.self).navigateBack)

  }
}
