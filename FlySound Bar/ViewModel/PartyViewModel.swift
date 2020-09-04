//
//  Created by Edward Nagy on 28/08/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation

final class PartyViewModel {

    private var context = CoreDataStack.shared.managedObjectContext
    private var parties: [Party]?

    init() {
        setParties()
    }

    private func setParties() {
        do {
            parties = try context.fetch(Party.fetchRequest())
        } catch(let error) {
            log.error(error.localizedDescription)
            parties = []
        }
    }
}

// MARK: Table View Properties
extension PartyViewModel {

    var numberOfSections: Int { 1 }
    var numberOfRows: Int { parties?.count ?? 0 }
}
