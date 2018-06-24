//
//  UITestCase.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 18/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import iOSBenrinaAutomationHelpers
import XCTest

/**
 holding application setup object
 */
public var appSettings: UIApplicationSetup?

/**
 global defaultScreenWaitTimeout
*/
public var defaultScreenWaitTimeout: TimeInterval = 10.0


open class UITestCase: XCTestCase {
  public var defaultStartingScreen: UITestScreen.Type?

  var appSetup: UIApplicationSetup {
    return appSettings!
  }

  /**
   navigation helper object used to find paths between screens
   */
  var navigationHelper: UITestScreenPathFinder = .init()

  /**
   storing current active screen - should be overriden in setUp to reflect app home screen
   */
  var currentScreen: UITestScreen.Type = UITestScreen.self

  /**
   feature toggles - dictionary - used to toggle features in app by passing them as part of
   */
  open var featureToggles: [String: String] = [:]

  override open func setUp() {
    super.setUp()
    continueAfterFailure = false
    if appSettings == nil {
      appSettings = .init(app: .init(), startScreen: defaultStartingScreen!)
      appSettings?.defaultLaunchSetup()
      appSettings?.setLaunchEnvironment(featureToggles)
    }
  }

  /**
   launches app that we set during setUp()
   */
  func launch() {
    appSetup.app.launch()
  }
  
  override open func tearDown() {
    super.tearDown()
    appSettings = nil
  }
}
