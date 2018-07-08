//
//  UIDemoTestCaseJA.swift
//  iOSAutomationDemoAppUITests
//
//  Created by Pavel Balint on 08/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import iOSKonbiniAutomation

class UIDemoTestCaseJA: UITestCase {
  override func setUp() {
    defaultStartingScreen = Home.self
    addUISystemAlertHandler(settings: SystemAlertHandlerSettings(description: "Location permission", text: "access your location", action: "Allow"))
    super.setUp()
    appSettings?.setAppLocale(locale: .custom(localeIdentifier: "ja"))
    appSettings?.setLocalisationLaunchArguments()
    launch()
  }
}
