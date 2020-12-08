//
//  Created by Edward Nagy on 04/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import UIKit

final class PartyCell: UITableViewCell {

    @IBOutlet private weak var partyView: UIView!
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var incomeLabel: UILabel!

    func setup(party: Party) {
        setupViews()
        nameLabel.text = party.name
        dateLabel.text = party.date?.formatDate()
        incomeLabel.text = "\(party.income) RON"
        incomeLabel.textColor = UIColor(named: "FlySoundGreen")
        
        if let imageData = party.image {
            coverImageView.image = UIImage(data: imageData)
        } else {
            coverImageView.image = UIImage(named: "BarIcon")
        }
    }

    private func setupViews() {
        partyView.layer.cornerRadius = 10
        coverImageView.layer.masksToBounds = true
        coverImageView.layer.cornerRadius = 10
    }
}
