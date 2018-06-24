//
//  ElementWaiters.swift
//  iOSKonbiniAutomation
//
//  Created by Pavel Balint on 18/06/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import iOSBenrinaAutomationHelpers
import XCTest

/**
 Waits for element to fulfil predicates before timeout
 - NOTE: if elements doesn't fulfil the predicates before timeout, test fails

 ## Usage Example: ##
 ````
 let element = XCUIApplication().buttons.element
 WaitFor(element: element, to [.isEnabled], atMost: 2)
 ````

 - Parameter element: observed element
 - Parameter predicates: array of predicates [ElementPredicate] that descendants should fulfil.
 - Parameter timeout: maximum time of the wait.
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func WaitFor(element: XCUIElement, to predicates: [ElementPredicate], atMost timeout: TimeInterval = defaultTimeout, file: StaticString = #file, line: UInt = #line) {
  return XCTContext.runActivity(named: "Waiting for element to \"\(NSPredicate(elementPredicates: predicates).predicateFormat)\" within \(timeout)s for \(element.debugDescription)") { _ -> Void in
    XCTAssertTrue(element.wait(until: predicates, atMostFor: timeout), file: file, line: line)
  }
}

/**
 Tries to wait for element to fulfil predicates before timeout
 - NOTE: non failing function

 ## Usage Example: ##
 ````
 let element = XCUIApplication().buttons.element
 let succeeded = TryToWaitFor(element: element, to [.isEnabled], atMost: 2)
 ````

 - Parameter element: observed element
 - Parameter predicates: array of predicates [ElementPredicate] that descendants should fulfil.
 - Parameter timeout: maximum time of the wait.

 - Returns: True if element predicates were satisfied witin time limit for chosen element
 */
public func TryToWaitFor(element: XCUIElement, to predicates: [ElementPredicate], atMost timeout: TimeInterval = defaultTimeout) -> Bool {
  return XCTContext.runActivity(named: "Trying to wait for element to \"\(NSPredicate(elementPredicates: predicates).predicateFormat)\" within \(timeout)s for \(element.debugDescription)") { _ -> Bool in
    return element.wait(until: predicates, atMostFor: timeout)
  }
}

/**
 Enters text into element after clearing it first.
 - NOTE: fails test if text didn't get set correctly

 ## Usage Example: ##
 ````
 let element = XCUIApplication().textFields.element
 EnterText(into: element, text: "test")
 ````

 - Parameter element: observed element
 - Parameter text: text to be entered
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func EnterText(into element: XCUIElement, text: String, file: StaticString = #file, line: UInt = #line) {
  let currentElementValue = element.value as! String
  if(currentElementValue == text) { return }
  XCTContext.runActivity(named: "Trying to enter \"\(text)\" into \(element.description)") { _ in
    element.clearAndEnter(text: text)

    XCTAssertTrue(element.wait(until: [.equals(.value, text)], atMostFor: 1),
                  "Element didn't get set to: \(text), but has value: \(element.value as! String)",
                  file: file, line: line)
  }
}

/**
 Appends text into element by clearing it first and then entering original text + appended text.
 - NOTE: fails test if text didn't get set correctly

 ## Usage Example: ##
 ````
 let element = XCUIApplication().textFields.element
 AppendText(into: element, text: "test")
 ````

 - Parameter element: observed element
 - Parameter text: text to be entered
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func AppendText(into element: XCUIElement, text: String, file: StaticString = #file, line: UInt = #line) {
  let mergedText = "\(element.value as! String)\(text)"
  XCTContext.runActivity(named: "Trying to append \"\(text)\" into \(element.description)") { _ in
    element.clearAndEnter(text: mergedText)

    XCTAssertTrue(element.wait(until: [.equals(.value, mergedText)], atMostFor: 1),
                  "Element didn't get set to: \(mergedText), but has value: \(element.value as! String)",
      file: file, line: line)
  }
}

/**
 Swipes in chosen direction on element until target element becomes hittable
 - NOTE: fails test if target element doesn't become hittable

 ## Usage Example: ##
 ````
 let windowElement = XCUIApplication().windows.element
 let targetElement = XCUIApplication().buttons["Button"]
 Swipe(on: windowElement, until: targetElement)
 ````

 - Parameter direction: swipe direction
 - Parameter element: element on which we're swiping
 - Parameter hittableElement: target element that we expect to become hittable
 - Parameter swipeLength: length of swipe used
 - Parameter times: maximum number of swipes being used
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.
 */
public func Swipe(direction: SwipeDirection = .up ,
           on element: XCUIElement,
           until hittableElement: XCUIElement,
           length swipeLength: SwipeLength = defaultSwipeLength,
           atMost times: Int = 3,
           file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Swipes on (\(element.description) until element \(hittableElement.description) becomes hittable") { _ in
    XCTAssertTrue(element.swipeUntilAnotherElement(becomesHittable: hittableElement, direction: direction, length: swipeLength, maximumRepeats: times),
                  "Element didn't become hittable",
      file: file, line: line)
  }
}

/**
 Perform drag action from dragged element to destination element
 - NOTE: fails test if both dragged element and destination element aren't hittable to begin with

 ## Usage Example: ##
 ````
 let draggedElement = XCUIApplication().images.element
 let destinationElement = XCUIApplication().views.element
 Drag(from: draggedElement, to: destinationElement)
 ````

 - Parameter origin: dragged element
 - Parameter destination: element on which we're swiping
 - Parameter dragDuration: duration of the drag gesture
 - Parameter times: maximum number of swipes being used
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func Drag(from origin: XCUIElement, to destination: XCUIElement, dragDuration: TimeInterval = 0.01, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Drags origin element (\(origin.description) to destination element \(destination.description)") { _ in
    if !origin.wait(until: [.isHittable], atMostFor: 1) {
      XCTFail("Can't drag from \(origin.debugDescription). Origin element not hittable", file: file, line: line)
    }
    if !destination.wait(until: [.isHittable], atMostFor: 1) {
      XCTFail("Can't drag to \(destination.debugDescription). Destination element not hittable", file: file, line: line)
    }
    
    origin.press(forDuration: dragDuration, thenDragTo: destination)
  }
}

/**
 Perform tap action on element. Number of taps and touch points are optional
 - NOTE: fails test if element doesn't exist

 ## Usage Example: ##
 ````
 Tap(on: XCUIApplication().buttons.element)
 ````

 - Parameter element: element being tapped
 - Parameter withNumberOfTaps: number of taps (optional)
 - Parameter numberOfTouches: number of touch points (optional)
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func Tap(on element: XCUIElement, withNumberOfTaps: Int = 1, numberOfTouches: Int = 1, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to tap on \(element.description) with \(withNumberOfTaps) taps and \(numberOfTouches) touches") { _ in
    WaitFor(element: element, to: [.exists])
    element.tap(withNumberOfTaps: withNumberOfTaps, numberOfTouches: numberOfTouches)
  }
}

/**
 Perform double tap action on element.
 - NOTE: fails test if element doesn't exist

 ## Usage Example: ##
 ````
 DoubleTap(on: XCUIApplication().buttons.element)
 ````

 - Parameter element: element being tapped
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func DoubleTap(on element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to double tap on \(element.description)") { _ in
    WaitFor(element: element, to: [.exists])
    element.doubleTap()
  }
}

/**
 Perform two finger tap action on element.
 - NOTE: fails test if element doesn't exist

 ## Usage Example: ##
 ````
 TwoFingerTap(on: XCUIApplication().buttons.element)
 ````

 - Parameter element: element being tapped
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func TwoFingerTap(on element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to do two finger tap on \(element.description)") { _ in
    WaitFor(element: element, to: [.exists])
    element.twoFingerTap()
  }
}

/**
 Perform swipe up action on element.
 - NOTE: fails test if element doesn't exist

 ## Usage Example: ##
 ````
 SwipeUp(on: XCUIApplication().buttons.element)
 ````

 - Parameter element: element being swiped
 - Parameter times: how many times swipe action is performed (optional)
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func SwipeUp(on element: XCUIElement, times: Int = 1, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to swipe up on \(element.description) \(times) times") { _ in
    WaitFor(element: element, to: [.exists])
    element.swipeUp(repeats: times)
  }
}

/**
 Perform swipe down action on element.
 - NOTE: fails test if element doesn't exist

 ## Usage Example: ##
 ````
 SwipeDown(on: XCUIApplication().buttons.element)
 ````

 - Parameter element: element being swiped
 - Parameter times: how many times swipe action is performed (optional)
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func SwipeDown(on element: XCUIElement, times: Int = 1, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to swipe down on \(element.description) \(times) times") { _ in
    WaitFor(element: element, to: [.exists])
    element.swipeDown(repeats: times)
  }
}

/**
 Perform swipe left action on element.
 - NOTE: fails test if element doesn't exist

 ## Usage Example: ##
 ````
 SwipeLeft(on: XCUIApplication().buttons.element)
 ````

 - Parameter element: element being swiped
 - Parameter times: how many times swipe action is performed (optional)
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func SwipeLeft(on element: XCUIElement, times: Int = 1, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to swipe left on \(element.description) \(times) times") { _ in
    WaitFor(element: element, to: [.exists])
    element.swipeLeft(repeats: times)
  }
}

/**
 Perform swipe right action on element.
 - NOTE: fails test if element doesn't exist

 ## Usage Example: ##
 ````
 SwipeRight(on: XCUIApplication().buttons.element)
 ````

 - Parameter element: element being swiped
 - Parameter times: how many times swipe action is performed (optional)
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func SwipeRight(on element: XCUIElement, times: Int = 1, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to swipe right on \(element.description) \(times) times") { _ in
    WaitFor(element: element, to: [.exists])
    element.swipeRight(repeats: times)
  }
}

/**
 Sets picker to chosen picker value.
 - NOTE: fails test if picker doesn't exist or if value doesn't exists in picker

 ## Usage Example: ##
 ````
 AdjustPickerTo(picker: XCUIApplication().pickers.element, value: "Test")
 ````

 - Parameter picker: picker element
 - Parameter value: picker value to be set
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func AdjustPickerTo(picker: XCUIElement, value: String, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to set picker \(picker.description) to \(value)") { _ in
    WaitFor(element: picker, to: [.exists])
    picker.adjust(toPickerWheelValue: value)
  }
}

/**
 Sets slider to chosen value.
 - NOTE: fails test if slider element doesn't exist

 ## Usage Example: ##
 ````
 AdjustSlider(picker: XCUIApplication().sliders.element, value: 0.5)
 ````

 - Parameter slider: slider element
 - Parameter value: A normalized slider value of 0 corresponds to the minimum value of the slider, and 1 corresponds to the maximum value.
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func AdjustSlider(slider: XCUIElement, value: CGFloat, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to set slider \(slider.description) to \(value)") { _ in
    WaitFor(element: slider, to: [.exists])
    slider.adjust(toNormalizedSliderPosition: value)
  }
}

/**
 Performs pinch gesture on element.
 - NOTE: fails test if element doesn't exist

 ## Usage Example: ##
 ````
 Pinch(on: XCUIApplication().images.element, withScale: 0.5, velocity: 0.5)
 ````

 - Parameter element: element that we perform pinch gesture on
 - Parameter withScale: The scale of the pinch gesture. Use a scale between 0 and 1 to "pinch close" or zoom out and a scale greater than 1 to "pinch open" or zoom in.
 - Parameter velocity: The velocity of the pinch in scale factor per second.
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func Pinch(on element: XCUIElement, withScale: CGFloat, velocity: CGFloat, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to pinch on \(element.description) with scale \(withScale) and velocity \(velocity)") { _ in
    WaitFor(element: element, to: [.exists])
    element.pinch(withScale: withScale, velocity: velocity)
  }
}


/**
 Performs press gesture on element for specified duration.
 - NOTE: fails test if slider element doesn't exist

 ## Usage Example: ##
 ````
 Press(on: XCUIApplication().images.element, forDuration: 0.5)
 ````

 - Parameter element: element that we perform press gesture on
 - Parameter forDuration: Duration of the press in seconds.
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func Press(on element: XCUIElement, forDuration: TimeInterval, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to press \(element.description) for \(forDuration) seconds") { _ in
    WaitFor(element: element, to: [.exists])
    element.press(forDuration: forDuration)
  }
}

/**
 Performs rotation gesture with two touches on element.
 - NOTE: fails test if element doesn't exist
 - WARNING: The system makes a best effort to synthesize the requested rotation and velocity, but absolute accuracy is not guaranteed. Some values may not be possible based on the size of the element's frame; these will result in test failures.

 ## Usage Example: ##
 ````
 Rotate(on: XCUIApplication().images.element, rotation: 0.5, withVelocity: 0.5)
 ````

 - Parameter element: element that we perform pinch gesture on
 - Parameter rotation: The rotation of the gesture in radians.
 - Parameter velocity: The velocity of the rotation gesture in radians per second.
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func Rotate(on element: XCUIElement, rotation: CGFloat, withVelocity: CGFloat, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to rotate \(element.description) with rotation \(rotation) and velocity \(withVelocity)") { _ in
    WaitFor(element: element, to: [.exists])
    element.rotate(rotation, withVelocity: withVelocity)
  }
}

/**
 Attempts to toggle switch element by tapping on it.
 - NOTE: fails test if switch element doesn't exist or value after tapping on it doesn't change

 ## Usage Example: ##
 ````
 ToggleSwitch(on: XCUIApplication().switches.element)
 ````

 - Parameter element: switch element that we perform toggle gesture on
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func ToggleSwitch(switch element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to toggle switch \(element.description)") { _ in
    WaitFor(element: element, to: [.exists])
    XCTAssertTrue(element.toggle(), "Element didn't change value", file: file, line: line)
  }
}

/**
 Attempts to set switch element to chosen setting by tapping on it.
 - NOTE: fails test if switch element doesn't exist or value after gesture isn't correct

 ## Usage Example: ##
 ````
 SetSwitch(on: XCUIApplication().switches.element, switchValue: true)
 ````

 - Parameter element: switch element we want to set
 - Parameter switchValue: switch value we want to set
 - Parameter file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
 - Parameter line: The line number on which failure occurred. Defaults to the line number on which this function was called.

 */
public func SetSwitch(switch element: XCUIElement, switchValue: Bool, file: StaticString = #file, line: UInt = #line) {
  XCTContext.runActivity(named: "Trying to toggle switch \(element.description)") { _ in
    WaitFor(element: element, to: [.exists])
    XCTAssertTrue(element.setSwitchTo(switchValue), "Element didn't change value", file: file, line: line)
  }
}
