//
//  TraitStrategy.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 23/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import XCTest
import iOSBenrinaAutomationHelpers

/**
 Trait strategy enum containing strategies to check whether we're on chosen screen
 */
public enum TraitStrategy {

  /**
   strategy that expects at least one element with accessibility identifierPrefix
   */
  case anyWithScreenIdentifierPrefix(elementType: XCUIElement.ElementType, identifierPrefix: String)
  /**
   strategy that expects at least specified number of elements with accessibility identifierPrefix
   */
  case atLeastXWithScreenIdentifierPrefix(elementType: XCUIElement.ElementType, identifierPrefix: String, minimumCount: Int)
  /**
   strategy that expects at least one element with attribute with prefix
   */
  case anyWithElementAtrributePrefix(elementType: XCUIElement.ElementType, elementAttribute: ElementAttribute, attributePrefix: String)
  /**
   strategy that expects at least specified number of elements with attribute with prefix
   */
  case atLeastXWithElementAtrributePrefix(elementType: XCUIElement.ElementType, elementAttribute: ElementAttribute, attributePrefix: String, minimumCount: Int)
  /**
   strategy that expects specified elements to exist
   */
  case specificElements([XCUIElement])

  /**
   checks trait strategy
   */
  public func traitCheck() -> Bool {
    switch self {
    case .anyWithScreenIdentifierPrefix(let elementType, let identifierPrefix):
      return appSettings!.app.descendants(ofType: elementType, which: [.beginsWith(.identifier, identifierPrefix)]).count > 0
    case .atLeastXWithScreenIdentifierPrefix(let elementType, let identifierPrefix, let minimumCount):
      return appSettings!.app.descendants(ofType: elementType, which: [.beginsWith(.identifier, identifierPrefix)]).count >= minimumCount
    case .anyWithElementAtrributePrefix(let elementType, let elementAttribute, let attributePrefix):
      return appSettings!.app.descendants(ofType: elementType, which: [.beginsWith(elementAttribute, attributePrefix)]).count > 0
    case .atLeastXWithElementAtrributePrefix(let elementType, let elementAttribute, let attributePrefix, let minimumCount):
      return appSettings!.app.descendants(ofType: elementType, which: [.beginsWith(elementAttribute, attributePrefix)]).count >= minimumCount
    case .specificElements(let traitElements):
      for element in traitElements {
        if !element.exists {
          return false
        }
      }
      return true
    }
  }
}
