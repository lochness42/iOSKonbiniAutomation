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

public class ScreenA: UITestScreen {
  required init() {
    super.init()
    setScreenTraitStrategy(.anyWithScreenIdentifierPrefix(elementType: .any, identifierPrefix: "test"))
    self.connectTo(screen: ScreenB.self, transition: {visited.append("A->B")})
    self.connectTo(screen: ScreenC.self, transition: {visited.append("A->C")})
  }
}

public class ScreenB: UITestScreen {
  required init() {
    super.init()
    setScreenTraitStrategy(.anyWithScreenIdentifierPrefix(elementType: .any, identifierPrefix: "test"))
    self.connectTo(screen: ScreenA.self, transition: {visited.append("B->A")})
  }
}

public class ScreenC: UITestScreen {
  required init() {
    super.init()
    setScreenTraitStrategy(.anyWithScreenIdentifierPrefix(elementType: .any, identifierPrefix: "test2"))
    self.connectTo(screen: ScreenB.self, transition: {visited.append("C->B")})
  }
}

public class ScreenD: UITestScreen {
  required init() {
    super.init()
    setScreenTraitStrategy(.specificElements([]))
    self.connectTo(screen: ScreenC.self, transition: {visited.append("D->C")})
  }
}

class GraphFinding: XCTestCase {

  func testCalculateExistingRoute() {
    let finder = UITestScreenPathFinder()
    let possiblePath = finder.findPath(from: ScreenD.self, to: ScreenA.self)
    if let path = possiblePath  {
      for edge in path {
        edge.transition()
      }
    }
    XCTAssertEqual(visited, ["D->C", "C->B", "B->A"])
  }

  func testNoRouteExistsBetweenScreens() {
    let finder = UITestScreenPathFinder()
    let possiblePath = finder.findPath(from: ScreenC.self, to: ScreenD.self)
    XCTAssertNil(possiblePath)
  }

}
