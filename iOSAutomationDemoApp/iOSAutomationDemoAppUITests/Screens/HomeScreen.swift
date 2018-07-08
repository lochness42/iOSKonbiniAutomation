//
//  HomeScreen.swift
//  iOSAutomationDemoAppUITests
//
//  Created by Pavel Balint on 03/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers
import iOSKonbiniAutomation

class Home: UITestScreen {
  override var screenIdentifierPrefix: String {
    return "home"
  }

  public var table: XCUIElement {
    return app.descendants(ofType: .table, which: [.equals(.identifier, "\(screenIdentifierPrefix).table")]).element(boundBy: 0)
  }

  public var delayWaitScreenCell: XCUIElement {
    return table.descendants(ofType: .cell, which: [.endsWith(.identifier, ".delaywait")]).element(boundBy: 0)
  }

  public var datePickerScreenCell: XCUIElement {
    return table.descendants(ofType: .cell, which: [.endsWith(.identifier, ".datepicker")]).element(boundBy: 0)
  }

  public var mapScreenCell: XCUIElement {
    return table.descendants(ofType: .cell, which: [.endsWith(.identifier, ".map")]).element(boundBy: 0)
  }

  public var scrollViewScreenCell: XCUIElement {
    return table.descendants(ofType: .cell, which: [.endsWith(.identifier, ".scrollview")]).element(boundBy: 0)
  }
  
  required init() {
    super.init()
    setScreenTraitStrategy(.anyWithScreenIdentifierPrefix(elementType: .other, identifierPrefix: screenIdentifierPrefix))
    connectTo(screen: ScrollView.self, transition: { Tap(on: self.scrollViewScreenCell) })
    connectTo(screen: DelayWait.self, transition: { Tap(on: self.delayWaitScreenCell) })
    connectTo(screen: DatePicker.self, transition: { Tap(on: self.datePickerScreenCell) })
    connectTo(screen: Map.self, transition: { Tap(on: self.mapScreenCell) })
  }
}
