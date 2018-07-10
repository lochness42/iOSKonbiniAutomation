//
//  UITestScreen.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 19/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest

/**
 Protocol to allow us to use generics for function that provides new instance of screen objects
 or reuses existing instance if it already exists
 */
public protocol UITestScreenInitialisableProtocol {
  init()
}

protocol UITestScreenProtocol {
  /**
   optional screen identifier (preferred to have it)
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

  func addIdentifierPrefixTo(_ sufix: String) -> String
}

open class UITestScreen: UITestScreenProtocol, UITestScreenInitialisableProtocol {
  var screenConnections: [UITestScreenEdge] = []

  required public init() {}
  public var isCurrentScreen: Bool {
    return screenTraitStrategy.traitCheck()
  }
  
  public var app: XCUIApplication {
    return appSettings!.app
  }
  
  open var screenIdentifierPrefix: String {
    return ""
  }

  func addIdentifierPrefixTo(_ sufix: String) -> String {
    return String(format: "%@.%@", screenIdentifierPrefix, sufix)
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
