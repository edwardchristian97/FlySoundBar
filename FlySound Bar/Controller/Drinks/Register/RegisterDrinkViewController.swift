//
//  Created by Edward Nagy on 07/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

final class RegisterDrinkViewController: UIViewController {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var drinkCategoryPicker: UIPickerView!
    @IBOutlet private weak var picker: UIPickerView!

    private let viewModel = RegisterDrinkViewModel()
    private var selectedOption = ""
    var onClose: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setup()
    }
}

// MARK: UI Setup
extension RegisterDrinkViewController {

    private func setup() {
        picker.selectRow(0, inComponent: 0, animated: true)
        selectedOption = viewModel.titleForRowInPicker(0)
    }
}

// MARK: Actions
extension RegisterDrinkViewController {

    @IBAction func addButtonTapped(_ sender: RoundButton) {
        guard let drinkType = DrinkType.allCases.first(where: { $0.rawValue == selectedOption }) else { return }
        let drink = DrinkData(type: drinkType, drinks: [textField.text ?? ""])
        viewModel.registerDrink(drink)
        onClose?()
    }
}

// MARK: Text Field Delegate
extension RegisterDrinkViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Picker Data Source
extension RegisterDrinkViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        viewModel.numberOfComponentsInPicker
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.numberOfRowsInPicker
    }
}

// MARK: Picker Delegate
extension RegisterDrinkViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.titleForRowInPicker(row)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = viewModel.titleForRowInPicker(row)
    }
}
