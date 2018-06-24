//
//  UITestScreen.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 19/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest

protocol UITestScreenProtocol {
  /**
   mandatory screen identifier which has be unique
   */
  var screenIdentifierPrefix: String { get }
  /**
   screen trait strategy to be used to verify that this screen is displayed
   */
  var screenTraitStrategy: TraitStrategy { get }
  /**
   list of connections to other screens
   */
  var screenConnections: [UITestScreenEdge] { get }
}

open class UITestScreen: UITestScreenProtocol, Equatable {
  var screenConnections: [UITestScreenEdge] = []

  public static func == (lhs: UITestScreen, rhs: UITestScreen) -> Bool {
    return lhs.screenTraitStrategy == rhs.screenTraitStrategy
  }

  required public init() {}
  public var isCurrentScreen: Bool {
    return screenTraitStrategy.traitCheck()
  }
  
  var app: XCUIApplication {
    return appSettings!.app
  }
  
  public var screenIdentifierPrefix: String {
    return ""
  }
  open var screenTraitStrategy: TraitStrategy = .specificElements([])
  /**
   trait strategy setter for screen

   - Parameter traitStrategy: strategy best describing state where current screen is loaded
   */
  public func setScreenTraitStrategy(_ traitStrategy: TraitStrategy) {
    screenTraitStrategy = traitStrategy
  }

}
