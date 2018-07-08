//
//  DatePickerScreen.swift
//  iOSAutomationDemoAppUITests
//
//  Created by Pavel Balint on 08/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers
import iOSKonbiniAutomation

class DatePicker: UITestScreen {
  override var screenIdentifierPrefix: String {
    return "datePicker"
  }

  public var datePickerView: XCUIElement {
    return app.descendants(ofType: .other, which: [.equals(.identifier, screenIdentifierPrefix)]).element(boundBy: 0)
  }

  public var datePicker: XCUIElement {
    return datePickerView.descendants(ofType: .datePicker, which: [.endsWith(.identifier, ".date")]).element(boundBy: 0)
  }

  public var modeButton: XCUIElement {
    return datePickerView.descendants(ofType: .button,which: [.endsWith(.identifier, ".mode")]).element(boundBy: 0)
  }

  public var localeButton: XCUIElement {
    return datePickerView.descendants(ofType: .button, which: [.endsWith(.identifier, ".locale")]).element(boundBy: 0)
  }

  public var currentValueLabel: XCUIElement {
    return datePickerView.descendants(ofType: .staticText, which: [.endsWith(.identifier, ".currentValue")]).element(boundBy: 0)
  }

  required init() {
    super.init()
    setScreenTraitStrategy(.atLeastXWithScreenIdentifierPrefix(elementType: .any, identifierPrefix: screenIdentifierPrefix, minimumCount: 4))
    connectTo(screen: Home.self, transition: screen(NavigationBarComponent.self).navigateBack)
    connectTo(screen: DatePickerMode.self, transition: { Tap(on: self.modeButton) })
    connectTo(screen: DatePickerLocale.self, transition: { Tap(on: self.localeButton) })
  }
}
