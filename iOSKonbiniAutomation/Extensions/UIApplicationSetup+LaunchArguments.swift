//
//  UIApplicationSetup+LaunchArguments.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 20/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

extension UIApplicationSetup {
  open func defaultLaunchArgumentsSetup(arguments: [String] = []) {
    setLaunchArgumentsToDefaultTestArguments()
    setLocalisationLaunchArguments()
  }
  
  public func setLaunchArgumentsToDefaultTestArguments() {
    launchArguments = ProcessInfo.processInfo.arguments
  }
  
  public func setNamedLaunchArgumentParameter(name: String, value: String) {
    let launchArgumentParameterIndex = launchArguments.index(of: name)
    
    if (launchArgumentParameterIndex != nil) {
      launchArguments[launchArgumentParameterIndex! + 1] = value
    } else {
      launchArguments += [name, value]
    }
  }
  
  public func removeNamedLaunchArgumentParameter(name: String) {
    if let launchArgumentParameterIndex = launchArguments.index(of: name) {
      let launchArgumentValueIndex = launchArgumentParameterIndex.advanced(by: 1)
      launchArguments.remove(at: launchArgumentValueIndex)
      launchArguments.remove(at: launchArgumentParameterIndex)
    }
  }
}
