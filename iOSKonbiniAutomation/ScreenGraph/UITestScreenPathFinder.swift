//
//  UITestScreenPathFinder.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 23/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

class UITestScreenPathFinder {

  /**
   Screens waiting to be processed
   */
  private var queuedScreenNodesWithEdge: [(screen: String, edge: UITestScreenEdge)] = []
  /**
   Interim Calculated shortest paths from source screen
   */
  private var pathsToScreen: [String: [UITestScreenEdge]] = [:]

  /**
   Resets variables before search begins
   */
  private func resetVariables() {
    queuedScreenNodesWithEdge = []
    pathsToScreen = [:]
  }

  /**
   BFS shortest path through directed unweighted graph where nodes are screens and edges are connecting them
   - NOTE: returns nil if there is no path otherwise returns array fo edges leading to target screen

   ## Usage Example: ##
   ````
   let path = UITestScreenPathFinder().findPath(from: UITestScreenA.self, to: UITestScreenB.self)
   ````

   - Parameter from: starting screen
   - Parameter to: target screen
   */
  public func findPath(from: UITestScreen.Type, to: UITestScreen.Type) -> [UITestScreenEdge]? {
    resetVariables()

    processScreen(from)

    while(queuedScreenNodesWithEdge.count > 0 && pathsToScreen[String(describing: to)] == nil) {
      let nextScreenToProcess = queuedScreenNodesWithEdge.first!
      queuedScreenNodesWithEdge.removeFirst()
      processScreen(nextScreenToProcess.edge.target)
      setPathToScreen(nextScreenToProcess)
    }
    return pathsToScreen[String(describing: to)]
  }

  /**
   Updates shortest path from origin screen to currently procesed screen
   - Parameter edgeInformation: tuple containing screen name and connecting edge
   */
  private func setPathToScreen(_ edgeInformation: (screen: String, edge: UITestScreenEdge)) {
    if let pathToPredecessorOfNextScreenToProcess = pathsToScreen[String(describing: edgeInformation.edge.source)] {
      pathsToScreen[edgeInformation.screen] = pathToPredecessorOfNextScreenToProcess + [edgeInformation.edge]
    } else {
      pathsToScreen[edgeInformation.screen] = [edgeInformation.edge]
    }
  }

  /**
   Processes current screen. Adds shortest path, updates queued screen nodes
   - Parameter screen: screen to be processed
   */
  private func processScreen(_ screen: UITestScreen.Type) {
    let screenObject = screen.init()
    let currentlyEvaluatedEdges: [UITestScreenEdge] = screenObject.screenConnections
    for screenEdge in currentlyEvaluatedEdges {
      let checkedScreen = screenEdge.target
      if !hasScreenBeenAlreadyChecked(checkedScreen) && !isScreenAlreadyQueued(checkedScreen) {
        queuedScreenNodesWithEdge.append((screen: String(describing: checkedScreen), edge: screenEdge))
      }
    }
  }

  /**
   Checks whether screen is already in queue for processing
   - Parameter checkedScreen: screen to be checked
   - Returns: screen is already queued or not
   */
  private func isScreenAlreadyQueued(_ checkedScreen: UITestScreen.Type) -> Bool {
    return queuedScreenNodesWithEdge.contains(where: {String(describing: $0.screen) == String(describing: checkedScreen)})
  }

  /**
   Checks whether screen already has calculated shortest path from origin screen and thus been processed
   - Parameter checkedScreen: screen to be checked
   - Returns: screen was already checked
   */
  private func hasScreenBeenAlreadyChecked(_ checkedScreen: UITestScreen.Type) -> Bool {
    return pathsToScreen.keys.contains(String(describing: checkedScreen))
  }
}
