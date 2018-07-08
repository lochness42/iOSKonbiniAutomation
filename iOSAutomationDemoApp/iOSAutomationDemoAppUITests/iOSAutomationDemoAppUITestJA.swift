//
//  iOSAutomationDemoAppUITestJA.swift
//  iOSAutomationDemoAppUITestsJA
//
//  Created by Pavel Balint on 08/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers
import iOSKonbiniAutomation

class iOSAutomationDemoAppUITestsJA: UIDemoTestCaseJA {

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
