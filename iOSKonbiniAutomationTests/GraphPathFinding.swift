//
//  GraphFinding.swift
//  iOSKonbiniAutomationTests
//
//  Created by Pavel Balint on 23/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
@testable import iOSKonbiniAutomation

var visited: [String] = []
var initCounter: [String: Int] = [:]

public class ScreenA: UITestScreen {
  required public init() {
    super.init()
    initCounter[screenName] = (initCounter[screenName] == nil) ? 1 : initCounter[screenName]! + 1
    setScreenTraitStrategy(.anyWithScreenIdentifierPrefix(elementType: .any, identifierPrefix: "test"))
    self.connectTo(screen: ScreenB.self, transition: {visited.append("A->B")})
    self.connectTo(screen: ScreenC.self, transition: {visited.append("A->C")})
  }
}

public class ScreenB: UITestScreen {
  required public init() {
    super.init()
    initCounter[screenName] = (initCounter[screenName] == nil) ? 1 : initCounter[screenName]! + 1
    setScreenTraitStrategy(.anyWithScreenIdentifierPrefix(elementType: .any, identifierPrefix: "test"))
    self.connectTo(screen: ScreenA.self, transition: {visited.append("B->A")})
  }
}

public class ScreenC: UITestScreen {
  required public init() {
    super.init()
    initCounter[screenName] = (initCounter[screenName] == nil) ? 1 : initCounter[screenName]! + 1
    setScreenTraitStrategy(.anyWithScreenIdentifierPrefix(elementType: .any, identifierPrefix: "test2"))
    self.connectTo(screen: ScreenB.self, transition: {visited.append("C->B")})
  }
}

public class ScreenD: UITestScreen {
  required public init() {
    super.init()
    initCounter[screenName] = (initCounter[screenName] == nil) ? 1 : initCounter[screenName]! + 1
    setScreenTraitStrategy(.specificElements([]))
    self.connectTo(screen: ScreenC.self, transition: {visited.append("D->C")})
    self.connectTo(screen: ScreenB.self, transition: {visited.append("D->B")})
  }
}

class GraphFinding: XCTestCase {

  func testCalculateExistingRoute() {
    let finder = UITestScreenPathFinder()
    let possiblePath = finder.findPath(from: screen(ScreenD.self), to: screen(ScreenA.self))
    if let path = possiblePath  {
      for edge in path {
        edge.transition()
      }
    }
    XCTAssertEqual(visited, ["D->B", "B->A"])
  }

  func testNoRouteExistsBetweenScreens() {
    let finder = UITestScreenPathFinder()
    let possiblePath = finder.findPath(from: screen(ScreenC.self), to: screen(ScreenD.self))
    XCTAssertNil(possiblePath)
  }
}
