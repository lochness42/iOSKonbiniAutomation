//
//  DatePickerModeScreen.swift
//  iOSAutomationDemoAppUITests
//
//  Created by Pavel Balint on 08/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers
import iOSKonbiniAutomation

class DatePickerMode: UITestScreen {
  override var screenIdentifierPrefix: String {
    return "datePickerMode"
  }

  required init() {
    super.init()
    setScreenTraitStrategy(.anyWithScreenIdentifierPrefix(elementType: .other, identifierPrefix: screenIdentifierPrefix))
    connectTo(screen: DatePicker.self, transition: screen(NavigationBarComponent.self).save)
  }
}
