//
//  UITestUITestScreenEdge.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 23/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

/**
 Representing directed connection between two screen objects
 */
class UITestScreenEdge: Equatable {

  /**
   Representing source screen
   */
  var source: UITestScreen.Type

  /**
   Representing target screen
   */
  var target: UITestScreen.Type

  /**
   Representing transition action to target screen
   */
  var transition: () -> Void

  /**
   Representing post transition action (optional)
   */
  var postTransition: (() -> Void)?


  /**
   init function

   ## Usage Example: ##
   ````
   UITestScreenEdge(source: UITestScreenA.self,
                    target: UITestScreenB.self,
                    transition: {
                                  Tap(on: XCUIApplication().buttons.element)
                                })
   ````

   - Parameter source: source screen
   - Parameter target: target screen
   - Parameter transition: transition ot target action closure
   - Parameter postTransition: post transition action closure (optional, can be used if needed)
   */
  required init(source: UITestScreen.Type, target: UITestScreen.Type, transition: @escaping () -> Void, postTransition: (() -> Void)?) {
    self.source = source
    self.target = target
    self.transition = transition
    self.postTransition = postTransition
  }

  static func == (lhs: UITestScreenEdge, rhs: UITestScreenEdge) -> Bool {
    return String(describing: lhs.source) == String(describing: rhs.source) && String(describing: lhs.target) == String(describing: rhs.target)
  }

}
