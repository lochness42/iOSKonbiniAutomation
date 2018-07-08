//
//  MapScreen.swift
//  iOSAutomationDemoAppUITests
//
//  Created by Pavel Balint on 08/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers
import iOSKonbiniAutomation

class Map: UITestScreen {
  override var screenIdentifierPrefix: String {
    return "map"
  }

  public var mapView: XCUIElement {
    return app.descendants(ofType: .other, which: [.equals(.identifier, "\(screenIdentifierPrefix).mapView")]).element(boundBy: 0)
  }

  required init() {
    super.init()
    setScreenTraitStrategy(.anyWithScreenIdentifierPrefix(elementType: .other, identifierPrefix: screenIdentifierPrefix))
    connectTo(screen: Home.self, transition: screen(NavigationBarComponent.self).navigateBack)
  }
}
