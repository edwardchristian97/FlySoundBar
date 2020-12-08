//
//  Created by Edward Nagy on 09/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation

final class RegisterPartyViewModel {

    private var context = CoreDataStack.shared.managedObjectContext

    func registerParty(_ partyDTO: PartyDTO) {
        let party = Party(context: context)
        party.id = partyDTO.id
        party.name = partyDTO.name
        party.date = partyDTO.date
        party.image = partyDTO.image
        party.income = 0

        do {
            try context.save()
            log.info("Registered Party: \(party.name ?? "-")")
        } catch(let error) {
            log.error(error.localizedDescription)
        }
    }
}
