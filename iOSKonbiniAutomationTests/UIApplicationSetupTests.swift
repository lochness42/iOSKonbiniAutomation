//
//  UIApplicationSetupTests.swift
//  iOSKonbiniAutomationTests
//
//  Created by Pavel Balint on 02/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
@testable import iOSKonbiniAutomation

class UIApplicationSetupTests: XCTestCase {
  var applicationSetup: UIApplicationSetup?
  class StartScreen: UITestScreen {
  }
  
  override func setUp() {
    applicationSetup = UIApplicationSetup(startScreen: StartScreen.self)
  }

  override func tearDown() {
    applicationSetup = nil
  }

  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
}
