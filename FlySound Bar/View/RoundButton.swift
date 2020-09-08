//
//  Created by Edward Nagy on 04/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable
    var cornerRadius: CGFloat = 8 {
        didSet {
            setup()
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    private func setup() {
        layer.cornerRadius = cornerRadius
    }
}
