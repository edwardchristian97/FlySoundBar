//
//  Created by Edward Nagy on 07/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation

class DrinksViewModel {

    private var context = CoreDataStack.shared.managedObjectContext
    private var drinkData: [DrinkData] {
        let drinks = fetchDrinks()
        return loadDrinks(drinks)
    }
}
// MARK: Functions
extension DrinksViewModel {

    func fetchDrinks() -> [Drink] {
        do {
            return try context.fetch(Drink.fetchRequest())
        } catch(let error) {
            log.error(error.localizedDescription)
            return []
        }
    }

    private func loadDrinks(_ drinks: [Drink]) -> [DrinkData] {
        DrinkType.allCases.map { category in
            DrinkData(type: category, drinks: (drinks.filter { $0.type == category.rawValue }).map { ($0.name ?? "") })
        }
    }

    func drinkAt(indexPath: IndexPath) -> String {
        drinkData[indexPath.section].drinks[indexPath.row]
    }

    func removeDrinkAt(indexPath: IndexPath) {
        context.delete(fetchDrinks().first(where: { $0.name == drinkAt(indexPath: indexPath) })!)
        do {
            try context.save()
        } catch(let error) {
            log.error(error.localizedDescription)
        }
    }
}

// MARK: Table View Data
extension DrinksViewModel {

    var numberOfSections: Int { drinkData.count }
    func numberOfRows(inSection section: Int) -> Int { drinkData[section].drinks.count }
    func titleForHeaderInSection(_ section: Int) -> String { "\(drinkData[section].type.rawValue) - \(drinkData[section].type.price) RON" }
}
