//
//  Created by Edward Nagy on 28/08/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation

final class PartyViewModel {

    private var context = CoreDataStack.shared.managedObjectContext
    private var parties: [Party] {
        do {
            return try context.fetch(Party.fetchRequest())
        } catch(let error) {
            log.error(error.localizedDescription)
            return []
        }
    }

}

// MARK: Functions
extension PartyViewModel {

    func partyAt(index: Int) -> Party {
        parties[index]
    }

    func removePartyAt(index: Int) {
        context.delete(partyAt(index: index))
        do {
            try context.save()
        } catch(let error) {
            log.error(error.localizedDescription)
        }
    }

    func registerParty(_ partyDTO: PartyDTO) {
        let party = Party(context: context)
        party.id = partyDTO.id
        party.name = partyDTO.name
        party.date = partyDTO.date
        party.image = partyDTO.image

        do {
            try context.save()
            log.info("Registered Party: \(party.name ?? "-")")
        } catch(let error) {
            log.error(error.localizedDescription)
        }
    }
}

// MARK: Table View Properties
extension PartyViewModel {

    var numberOfSections: Int { 1 }
    var numberOfRows: Int { parties.count }
}
