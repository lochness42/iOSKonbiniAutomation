//
//  iOSAutomationDemoAppUITests.swift
//  iOSAutomationDemoAppUITests
//
//  Created by Pavel Balint on 03/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers
import iOSKonbiniAutomation

class iOSAutomationDemoAppUITests: UIDemoTestCase {
  override var featureToggles: [String: String] { return [
    "first_toggle": "first_value",
    "second_toggle": "second_value",
    "third_toggle": "third_value"
    ]}

  func testSetLaunchInfo() {
    NavigateToScreen(to: LaunchInfo.self)
    Tap(on: screen(LaunchInfo.self).launchArgumentsButton)
    WaitFor(element: screen(LaunchInfo.self).alert, to: [.exists])
    XCTAssertTrue(screen(LaunchInfo.self).verifyLaunchArguments(["test_argument_schema"]))
    screen(LaunchInfo.self).dismissAlert()
    Tap(on: screen(LaunchInfo.self).launchEnvironmentButton)

    WaitFor(element: screen(LaunchInfo.self).alert, to: [.exists])
    XCTAssertTrue(screen(LaunchInfo.self).verifyLaunchEnvironment(featureToggles, prefix: "test_environment_"))
    XCTAssertTrue(screen(LaunchInfo.self).verifyLaunchEnvironment(["test_environment_schema": "schema_value"]))
  }

  func testScrollViewHandling() {
    ScreenIsActive(Home.self)
    NavigateToScreen(to: ScrollView.self)
    Swipe(direction: .up, on: screen(ScrollView.self).scrollView, until: screen(ScrollView.self).showAlertButton, length: .long, atMost: 6)
    Tap(on: screen(ScrollView.self).showAlertButton)
    WaitFor(element: screen(ScrollView.self).alert, to: [.exists])
    screen(ScrollView.self).dismissAlert()
    NavigateToScreen(to: Home.self)
  }


  func testDelayWaitHandling() {
    ScreenIsActive(Home())
    NavigateToScreen(to: DelayWait.self)
    let activityIndicatorExists = TryToWaitFor(element: screen(DelayWait.self).activityIndicator, to: [.exists])
    XCTAssertFalse(activityIndicatorExists)
    WaitFor(element: screen(DelayWait.self).helloLabel, to: [.doesNotExist])
    Tap(on: screen(DelayWait.self).showButton)
    WaitFor(element: screen(DelayWait.self).showButton, to: [.doesNotExist])
    NoActivityIndicatorsAreDisplayed()
    WaitFor(element: screen(DelayWait.self).helloLabel, to: [.exists])
    WaitFor(element: screen(DelayWait.self).showButton, to: [.exists])
    NavigateToScreen(to: Home.self)
  }

  func testVariousGestures() {
    NavigateToScreen(to: Map.self)
    Rotate(on: screen(Map.self).mapView, rotation: 1.5, withVelocity: 1)
    Pinch(on: screen(Map.self).mapView, withScale: 0.1, velocity: -5)
    DoubleTap(on: screen(Map.self).mapView)
  }

  func testNavigationBetweenScreensInDifferentTreeBranches() {
    NavigateToScreen(to: DatePickerMode.self)
    NavigateToScreen(to: Map.self)
  }

  func testDatePickers() {
    NavigateToScreen(to: DatePicker.self)
  }
}
