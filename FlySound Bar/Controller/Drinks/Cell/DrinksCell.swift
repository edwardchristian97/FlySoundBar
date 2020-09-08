//
//  Created by Edward Nagy on 07/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

final class DrinksCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    private var count = 0

    func setup(drink: Drink) {
        nameLabel.text = drink.name
        priceLabel.text = "\(count)"
    }

    @IBAction func plusButtonTapped() {
        count = count + 1
        priceLabel.text = "\(count)"
    }

    @IBAction func minusButtonTapped() {
        count = count - 1
        if count < 0 {
            count = 0
        }
        priceLabel.text = "\(count)"
    }
}
