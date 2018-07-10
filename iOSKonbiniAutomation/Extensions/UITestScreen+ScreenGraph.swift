//
//  ScreenGraph.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 23/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

extension UITestScreen {
  /**
   Returns string representing current screen object
   */
  public var screenName: String {
    let thisScreenType = type(of: self)
    return String(describing: thisScreenType)
  }

  /**
   Sets connection between current screen and target screen

   ## Usage Example: ##
   ````
   func navigationStepsToScreenA(){}
   self.connectTo(screen: UITestScreenA.self, transition: navigationStepsToScreenA)
   ````

   - Parameter screen: target screen
   - Parameter transition: closure containing steps to make transition from current screen ot target screen
   - Parameter postTransition: optional steps to be performed after getting to target screen
   */
  public func connectTo(screen: UITestScreen.Type, transition: @escaping () -> Void, postTransition: (() -> Void)? = nil) {
    let connection: UITestScreenEdge = .init(source: type(of: self), target: screen, transition: transition, postTransition: postTransition)
    if (!self.screenConnections.contains { checkedConnection in
      return String(describing: connection.source) == String(describing: checkedConnection.source)
          && String(describing: connection.target) == String(describing: checkedConnection.target)}) {
      self.screenConnections.append(connection)
    }
  }
}
