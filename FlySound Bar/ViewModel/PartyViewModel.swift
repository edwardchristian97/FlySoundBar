//
//  Created by Edward Nagy on 28/08/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation

final class PartyViewModel {

    private var context = CoreDataStack.shared.managedObjectContext
    private var parties: [Party] {
        var parties = [Party]()
        do {
            parties = try context.fetch(Party.fetchRequest())
        } catch(let error) {
            log.error(error.localizedDescription)
        }

        return parties.sorted(by: { $0.date?.compare($1.date ?? Date()) == .orderedDescending })
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

    func updateTotal(_ total: Int64, forParty party: Party) {
        party.income = total
        do {
            try context.save()
        } catch {
            log.error(error.localizedDescription)
        }
    }
}

// MARK: Table View Properties
extension PartyViewModel {

    var numberOfSections: Int { 1 }
    var numberOfRows: Int { parties.count }
}
