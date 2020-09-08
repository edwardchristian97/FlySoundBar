//
//  Created by Edward Nagy on 07/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation

enum DrinkType: String, CaseIterable {

    case longDrinks = "LONG DRINKS"
    case beer = "BEER"
    case shots = "SHOTS"
    case softDrinks = "SOFT DRINKS"
    case others = "OTHERS"

    var price: Int {
        switch self {
        case .longDrinks: return 12
        case .beer: return 5
        case .shots: return 5
        case .softDrinks: return 5
        case .others: return 8
        }
    }

    var index: Int {
        switch self {
        case .longDrinks: return 0
        case .beer: return 1
        case .shots: return 2
        case .softDrinks: return 3
        case .others: return 4
        }
    }
}
