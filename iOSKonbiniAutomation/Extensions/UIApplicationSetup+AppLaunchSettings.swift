//
//  UIAppLaunchSettings.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 19/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import Foundation

extension UIApplicationSetup {
  /**
   List of predefined locales, still can use other locales
   */
  public enum Localisation {
    /**
     represents locale identifier "en_GB"
     */
    case GB
    /**
     represents locale identifier "en_US"
     */
    case US
    /**
     represents locale identifier "fr_FR"
     */
    case FR
    /**
     represents locale identifier "pt_PT"
     */
    case PT
    /**
     represents locale identifier "pt_BR"
     */
    case BR
    /**
     represents locale identifier "es_ES"
     */
    case ES
    /**
     represents locale with user specified identifier
     */
    case custom(localeIdentifier: String)

    internal var locale: Locale {
      switch self {
      case .GB: return Locale(identifier: "en_GB")
      case .US: return Locale(identifier: "en_US")
      case .FR: return Locale(identifier: "fr_FR")
      case .BR: return Locale(identifier: "pt_BR")
      case .PT: return Locale(identifier: "pt_PT")
      case .ES: return Locale(identifier: "es_ES")
      case .custom(localeIdentifier: let localeIdentifier): return Locale(identifier: localeIdentifier)
      }
    }
  }

  /**
   sets launch arguments to launch app in chosen locale/language based on **self.localisation** variable
  */
  public func setLocalisationLaunchArguments() {
    if (self.localisation != nil) {
      let locale = self.localisation!.locale
      setNamedLaunchArgumentParameter(name: "-AppleLocale", value: locale.identifier)
      if let languageCode = locale.languageCode {
        setNamedLaunchArgumentParameter(name: "-AppleLanguages", value: "(\(languageCode))")
      }
    }
  }
}
