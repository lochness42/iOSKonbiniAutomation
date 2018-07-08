//
//  UIApplicationSetup+LaunchParameters.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 20/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

extension UIApplicationSetup {
  open func defaultLaunchEnvironmentSetup(parameters: [String: String] = [:]) {
    setLaunchEnvironmentToDefaultTestParameters()
  }
  
  public func setLaunchEnvironmentToDefaultTestParameters() {
    launchEnvironment = ProcessInfo.processInfo.environment
  }
  
  public func setLaunchEnvironmentParameter(name: String, value: String) {
    launchEnvironment[name] = value
  }
  
  public func setLaunchEnvironment(_ parameters: [String: String]) {
    for (name, value) in parameters {
      setLaunchEnvironmentParameter(name: "test_environment_\(name)", value: value)
    }
  }
}
