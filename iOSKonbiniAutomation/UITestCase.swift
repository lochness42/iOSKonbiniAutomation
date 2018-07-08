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

/**
 global storage of screen instances
 */
var screens: [String: UITestScreen] = [:]

/**
 provides instance of screen object

 ## Usage Example: ##
 ````
 let screen: ScreenA = screen(ScreenA.self)
 ````

 - Parameter instanceOfScreen: screen object type that we want instance of
 - Returns: new screen instance if it wasn't instantiated before, otherwise returns existing object
 */
public func screen <ScreenObject: UITestScreenInitialisableProtocol>(_ instanceOfScreen: ScreenObject.Type) -> ScreenObject {
  let screenName = String(describing: instanceOfScreen)
  if screens[screenName] == nil {
    screens[screenName] = instanceOfScreen.init() as? UITestScreen
  }
  return screens[screenName] as! ScreenObject
}

open class UITestCase: XCTestCase {
  public var defaultStartingScreen: UITestScreen.Type?

  var appSetup: UIApplicationSetup {
    return appSettings!
  }

  /**
   navigation helper object used to find paths between screens
   */
  lazy var navigationHelper: UITestScreenPathFinder = {
    return UITestScreenPathFinder.init()
  }()

  /**
   storing current active screen - should be overriden in setUp to reflect app home screen
   */
  lazy var currentScreen: UITestScreen.Type = {
    return UITestScreen.self
  }()
  
  /**
   feature toggles - dictionary - used to toggle features in app by passing them as part of
   */
  open var featureToggles: [String: String] = [:]

  override open func setUp() {
    super.setUp()
    continueAfterFailure = false
    if appSettings == nil {
      appSettings = .init(startScreen: defaultStartingScreen!)
      appSettings?.defaultLaunchSetup()
      appSettings?.setLaunchEnvironment(featureToggles)
    }
    currentScreen = defaultStartingScreen!
  }

  /**
   launches app that we set during setUp()
   */
  public func launch() {
    appSetup.launch()
  }
  
  override open func tearDown() {
    super.tearDown()
    appSettings = nil
  }
}
