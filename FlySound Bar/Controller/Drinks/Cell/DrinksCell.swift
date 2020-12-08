//
//  Created by Edward Nagy on 07/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

final class DrinksCell: UITableViewCell {

    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!

    private var count = 0
    var onPlusTapped: (() -> Void)?
    var onMinusTapped: (() -> Void)?

    func setup(drinkName: String, quantity: Int) {
        cellView.layer.cornerRadius = 10
        nameLabel.text = drinkName
        quantityLabel.text = "\(quantity)"
    }

    func setColorForQuantity(_ quantity: Int) {
        let color = quantity > 0 ? UIColor(named: "FlySoundGreen") : .white
        nameLabel.textColor = color
        quantityLabel.textColor = color
    }

    @IBAction func plusButtonTapped() {
        onPlusTapped?()
    }

    @IBAction func minusButtonTapped() {
        onMinusTapped?()
    }
}
