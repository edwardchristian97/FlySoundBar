//
//  Created by Edward Nagy on 10/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

extension String {

    var attributed: NSAttributedString { NSAttributedString(string: self) }

    func with(font: UIFont, color: UIColor = .black) -> NSAttributedString {
        let result = NSMutableAttributedString(string: self,
                                               attributes: [.font: font,
                                                            .foregroundColor: color])
        return result
    }
}
