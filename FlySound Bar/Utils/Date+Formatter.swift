//
//  Created by Edward Nagy on 04/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation

extension Date {

    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
}
