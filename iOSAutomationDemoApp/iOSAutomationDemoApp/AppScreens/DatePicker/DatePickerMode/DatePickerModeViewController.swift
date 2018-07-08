//
//  DatePickerModeViewController.swift
//  iOSAutomationDemoApp
//
//  Created by Pavel Balint on 07/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import UIKit

class DatePickerModeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  @IBOutlet weak var modePicker: UIPickerView!

  @IBAction func saveMode(_ sender: Any) {
    datePickerState.mode = datePickerModes[modePicker.selectedRow(inComponent: 0)].mode
    self.dismiss(animated: true, completion: nil)
  }
  @IBAction func cancelModeSetup(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }

  override func viewWillAppear(_ animated: Bool) {
    for index in (0..<datePickerModes.count) {
      if datePickerState.mode == datePickerModes[index].mode {
        modePicker.selectRow(index, inComponent: 0, animated: true)
        break
      }
    }
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
  }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datePickerModes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datePickerModes[row].name
    }
}
