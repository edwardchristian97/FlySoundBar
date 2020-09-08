//
//  UIView+nib.swift
//  FlySound Bar
//
//  Created by Edward Nagy on 04/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

extension UIView {
    class var className: String {
        return String(describing: self)
    }

    class var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
}
