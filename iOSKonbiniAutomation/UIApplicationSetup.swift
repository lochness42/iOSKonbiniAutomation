//
//  UIApplicationSetup.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 20/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest

/**
 Object describing application under tests' setup
 */
open class UIApplicationSetup {
  private var _app: XCUIApplication

  /**
   Getter for  XCUIApplication object
   - Returns: Reference to XCUIApplication
   */
  public var app: XCUIApplication {
    return _app
  }

  public var currentScreen: UITestScreen.Type

  /**
   launch environment dictionary
   */
  public var launchEnvironment: [String: String] = [:]
  /**
   launch arguments array
   */
  public var launchArguments: [String] = []

  /**
   Localisation setup to be used for application launch
   */
  var localisation: Localisation?

  public init(app: XCUIApplication = .init(), startScreen: UITestScreen.Type) {
    self._app = app
    self.currentScreen = startScreen
  }

  /**
   Localisation setter to be used for application launch
   - Parameter locale: locale to be used when launching app
   */
  public func setLocaleApp(locale: Localisation) {
    localisation = locale
  }

  /**
   Loads default settings which are passed to test
   */
  open func defaultLaunchSetup() {
    defaultLaunchArgumentsSetup()
    defaultLaunchEnvironmentSetup()
  }

  /**
   Launches app with preset launch argument list and environment dictionary
   */
  open func launch() {
    app.launchArguments = launchArguments
    app.launchEnvironment = launchEnvironment
    app.launch()
  }
}
