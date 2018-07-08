//
//  DatePickerViewController.swift
//  iOSAutomationDemoApp
//
//  Created by Pavel Balint on 06/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import UIKit

public var datePickerState: (locale: Locale, mode: UIDatePickerMode) = (Locale.current, .dateAndTime)
public let datePickerModes: [(name: String, mode: UIDatePickerMode)] = [("time", .time), ("date", .date), ("dateAndTime", .dateAndTime), ("countDownTimer", .countDownTimer)]

public func getModeName(mode: UIDatePickerMode) -> String {
  for datePickerMode in datePickerModes {
    if datePickerMode.mode == mode {
      return datePickerMode.name
    }
  }
  return ""
}

class DatePickerViewController: UIViewController {
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var datePickerModeButton: UIButton!
  @IBOutlet weak var datePickerLocaleButton: UIButton!
  @IBOutlet weak var datePickerValueLabel: UILabel!

  let dateTimeFormat: [UIDatePickerMode: String] = [
    .time: "HH:mm",
    .date: "dd MMM yyyy",
    .dateAndTime: "dd MMM yyyy HH:mm",
    .countDownTimer: "HH:mm"
  ]

  var dateFormatter = DateFormatter()

  override func viewWillAppear(_ animated: Bool) {
    setupView()
  }
  override func viewDidLoad() {
    dateFormatter.locale = Locale.current
    setupView()
  }

  func setupView() {

    datePicker.locale = datePickerState.locale
    datePicker.datePickerMode = datePickerState.mode
    dateFormatter.dateFormat = dateTimeFormat[datePickerState.mode]
    datePickerValueLabel.text = dateFormatter.string(from: datePicker.date)

    datePickerModeButton.setTitle("Mode: \(getModeName(mode: datePickerState.mode))", for: .normal)
    datePickerLocaleButton.setTitle("Locale: \(datePickerState.locale.identifier)", for: .normal)


  }

  @IBAction func datePickerValueChanged(_ sender: Any) {
    setupView()
  }


}
