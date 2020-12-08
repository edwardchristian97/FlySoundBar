//
//  UITableView+dequeueCell.swift
//  FlySound Bar
//
//  Created by Edward Nagy on 04/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(cell: T.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.className)
    }

    func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className,
                                             for: indexPath) as? T else {
                                                fatalError("Failed to dequeue cell with identifier: \(T.className)")
        }

        return cell
    }
}
