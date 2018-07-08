//
//  UITestCase+InterruptionHandlers.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 19/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

extension UITestCase {
  public struct SystemAlertHandlerSettings {
    var description: String
    var text: String
    var action: String

    public init(description: String, text: String, action: String) {
      self.description = description
      self.text = text
      self.action = action
    }
  }

  public func addUISystemAlertHandler(settings: SystemAlertHandlerSettings) {
    addUIInterruptionMonitor(withDescription: settings.description) { (alert) -> Bool in
      if alert.descendants(ofType: .staticText, which: [.contains(.label, settings.text)]).element.exists {
        alert.buttons[settings.action].tap()
        return true
      }
      return false
    }
  }

}
