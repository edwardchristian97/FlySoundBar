//
//  Created by Edward Nagy on 08/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

final class PartyDetailsViewController: UIViewController {

    @IBOutlet private weak var testLabel: UILabel!
    var test: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = test
    }
    
}
