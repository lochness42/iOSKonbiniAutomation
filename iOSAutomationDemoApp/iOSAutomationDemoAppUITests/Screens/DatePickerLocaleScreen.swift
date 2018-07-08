//
//  DatePickerLocaleScreen.swift
//  iOSAutomationDemoAppUITests
//
//  Created by Pavel Balint on 08/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers
import iOSKonbiniAutomation

class DatePickerLocale: UITestScreen {
  override var screenIdentifierPrefix: String {
    return "datePickerLocale"
  }

  required init() {
    super.init()
    setScreenTraitStrategy(.atLeastXWithScreenIdentifierPrefix(elementType: .any, identifierPrefix: screenIdentifierPrefix, minimumCount: 3))
    connectTo(screen: DatePicker.self, transition: screen(NavigationBarComponent.self).save)
  }
}
