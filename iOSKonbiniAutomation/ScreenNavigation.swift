//
//  ScreenNavigation.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 24/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers

var navigationHelper = UITestScreenPathFinder()

/**
 Tries to navigate from currently active screen to target one
 - WARNING: fails test if there is no path between screens

 ## Usage Example: ##
 ````
 NavigateToScreen(to: UITestScreenA.self)
 ````

 - Parameter to: screen we want to navigate to
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.
 */
public func NavigateToScreen(to: UITestScreen.Type, file: StaticString = #file, line: UInt = #line) {
  let path = navigationHelper.findPath(from: appSettings!.currentScreen, to: to)
  XCTAssertNotNil(path, "There is no path between \(String(describing: appSettings!.currentScreen)) and \(String(describing: to))", file: file, line: line)
  for step in path! {
    step.transition()
    appSettings!.currentScreen = step.target
    ScreenIsActive(to, file: file, line: line)
    if let postTransition = step.postTransition {
      postTransition()
    }
  }
}

/**
 Tries to check whether screen becomes active within timeout. If we're on the screen current screen is being set to active screen
 - WARNING: fails test if screen isn't loaded within timeout

 ## Usage Example: ##
 ````
 ScreenIsActive(UITestScreenA.self)
 ````

 - Parameter screen: screen we expect to be active
 - Parameter timeout: timeout
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.
 */
public func ScreenIsActive(_ screen: UITestScreen.Type, within timeout: TimeInterval = defaultScreenWaitTimeout, file: StaticString = #file, line: UInt = #line) {
  var loaded = false
  let screenObject = screen.init()
  loaded =  repeatUntilTrueOrTimeout(repeatedAction: { return screenObject.isCurrentScreen}, timeout: timeout)
  if !loaded {
    loaded = screenObject.isCurrentScreen
  }
  XCTAssertTrue(loaded, "Screen \(String(describing: screen)) haven't been loaded within \(timeout)s", file: file, line: line)
  appSettings!.currentScreen = screen
}

/**
 Tries to wait for all activity indicators to disappear within timeout.

 ## Usage Example: ##
 ````
 NoActivityIndicatorsAreDisplayed(timeout: 10)
 ````

 - Parameter timeout: timeout for activity indicators to go away
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.
 */
public func NoActivityIndicatorsAreDisplayed(timeout: TimeInterval = defaultTimeout, file: StaticString = #file, line: UInt = #line) {
  var activityIndicatersAreNotDisplayed = repeatUntilTrueOrTimeout(repeatedAction: noActivityIndicatorsAreDisplayed, timeout: timeout)
  if !activityIndicatersAreNotDisplayed {
    activityIndicatersAreNotDisplayed = noActivityIndicatorsAreDisplayed()
  }
  XCTAssertTrue(activityIndicatersAreNotDisplayed, "There are still \(appSettings!.app.descendants(matching: .activityIndicator).count) activity indicators displayed", file: file, line: line)
}

private func noActivityIndicatorsAreDisplayed() -> Bool {
  return appSettings!.app.descendants(matching: .activityIndicator).count == 0
}

/**
 Repeats closure. To be used for element checks as they take quite while

 - Parameter repeatedAction: closure to be repeated until it returns true
 - Parameter timeout: timeout for closure to return true
 - Returns: returns whether closure returned true within timeout
 */
private func repeatUntilTrueOrTimeout(repeatedAction: () -> Bool, timeout: TimeInterval) -> Bool {
  var successful = false
  var timetaken: TimeInterval = 0.0
  let started = Date()
  while timetaken < timeout {
    successful = repeatedAction()
    if successful {
      break
    }
    timetaken = Date().timeIntervalSince(started)
  }
  return successful
}
