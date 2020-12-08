//
//  Created by Edward Nagy on 28/08/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

final class RegisterPartyViewController: UIViewController {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var datePicker: UIDatePicker!

    private let viewModel = RegisterPartyViewModel()
    var onClose: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
}

// MARK: Actions
extension RegisterPartyViewController {

    @IBAction private func addButtonTapped(_ sender: RoundButton) {
        let party = PartyDTO(id: UUID(),
                             name: textField.text ?? "",
                             date: datePicker.date,
                             image: UIImage(named: "BarIcon")?.pngData())
        viewModel.registerParty(party)
        onClose?()
    }
}

// MARK: Text Field Delegate
extension RegisterPartyViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
