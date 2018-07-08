//
//  DatePickerLocaleViewController.swift
//  iOSAutomationDemoApp
//
//  Created by Pavel Balint on 07/07/2018.
//  Copyright © 2018 Pavel Balint. All rights reserved.
//

import UIKit
import Foundation

class DatePickerLocaleViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  @IBOutlet weak var localePicker: UIPickerView!
  @IBOutlet weak var countryNameLabel: UILabel!

  let availableLocales: [String] = Locale.availableIdentifiers.sorted()

  var unknownLocales: [String: String] {
    var result: [String: String] = [:]
    for locale in Locale.availableIdentifiers.sorted().filter({ !($0 == Locale(identifier: $0).identifier)}) {
      result[Locale(identifier: locale).identifier] = locale
    }
    return result
  }

  override func viewWillAppear(_ animated: Bool) {
    var identifier = datePickerState.locale.identifier
    if unknownLocales[identifier] != nil {
      identifier = unknownLocales[identifier]!
    }

    countryNameLabel.text = englishNameForLocale(datePickerState.locale)
    let currentLocale: Int? = availableLocales.index(of: identifier)
    localePicker.selectRow(currentLocale ?? 0, inComponent: 0, animated: true)
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return availableLocales.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return availableLocales[row]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let localeCode = availableLocales[row]
    let locale = Locale(identifier: localeCode)
    countryNameLabel.text = englishNameForLocale(locale)
  }

  func englishNameForLocale(_ locale: Locale) -> String {
    return (Locale(identifier: "en") as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: locale.identifier) ?? "unknown"
  }
  
  @IBAction func saveLocale(_ sender: Any) {
    datePickerState.locale = Locale(identifier: availableLocales[localePicker.selectedRow(inComponent: 0)])
    self.dismiss(animated: true, completion: nil)
  }

  @IBAction func cancelLocaleSetup(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}
