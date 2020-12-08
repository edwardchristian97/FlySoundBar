//
//  Created by Edward Nagy on 07/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation

struct DrinkData {
    let type: DrinkType
    let drinks: [String]
}

class DrinkDTO {
    var name: String
    var price: Int64
    var quantity: Int64

    init(name: String, price: Int64, quantity: Int64) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}
