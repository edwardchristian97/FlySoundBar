//
//  Created by Edward Nagy on 04/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

extension UIViewController {

    func present(viewController: UIViewController) {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = .white
        viewController.navigationItem.leftBarButtonItem = closeButton
        present(viewController.navEmbedded, animated: true, completion: nil)
    }

    @objc private func closeButtonTapped() {
      dismiss(animated: true, completion: nil)
    }
}
