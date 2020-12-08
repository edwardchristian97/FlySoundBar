//
//  Created by Edward Nagy on 09/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation

class InventoryViewModel {
    
    private var context = CoreDataStack.shared.managedObjectContext
    private let drinksViewModel = DrinksViewModel()
    var inventoryDrinks = [InventoryDrink]()
    
    init() {
        resetInventory()
    }
}

// MARK: Functions
extension InventoryViewModel {
    
    var total: Int { inventoryDrinks.reduce(0, { $0 + $1.type.price * $1.quantity }) }
    
    func resetInventory() {
        let drinks = drinksViewModel.fetchDrinks()
        inventoryDrinks = drinks.map { InventoryDrink(type: drinkType($0.type)!, drinkName: $0.name ?? "", quantity: 0) }
    }
    
    private func drinkType(_ type: String?) -> DrinkType? {
        DrinkType.allCases.first(where: { $0.rawValue == type })
    }
    
    func drinkAt(indexPath: IndexPath) -> String {
        drinksViewModel.drinkAt(indexPath: indexPath)
    }
    
    func quantityAt(indexPath: IndexPath) -> Int {
        inventoryDrinks.first(where: { $0.drinkName == drinksViewModel.drinkAt(indexPath: indexPath)})?.quantity ?? 0
    }
    
    func increaseQuantityAt(indexPath: IndexPath) {
        // Variable used for log
        var quantity = 0
        inventoryDrinks.forEach {
            if $0.drinkName == drinksViewModel.drinkAt(indexPath: indexPath) {
                $0.quantity = $0.quantity + 1
                quantity = $0.quantity
            }
        }
        log.info("\(drinksViewModel.drinkAt(indexPath: indexPath)) +1 (Total: \(quantity))")
    }
    
    func decreaseQuantityAt(indexPath: IndexPath) {
        // Variable used for log
        var quantity = 0
        inventoryDrinks.forEach {
            if $0.drinkName == drinksViewModel.drinkAt(indexPath: indexPath) {
                $0.quantity = $0.quantity - 1
                if $0.quantity < 0 {
                    $0.quantity = 0
                }
                quantity = $0.quantity
            }
        }
        log.info("\(drinksViewModel.drinkAt(indexPath: indexPath)) -1 (Total: \(quantity))")
    }

    func addDrinksToParty(_ party: Party) {
        inventoryDrinks.forEach {
            let paidDrink = PaidDrink(context: context)
            if $0.quantity > 0 {
                paidDrink.name = $0.drinkName
                paidDrink.type = $0.type.rawValue
                paidDrink.quantity = Int64($0.quantity)
                paidDrink.toParty = party

                do {
                    try context.save()
                } catch(let error) {
                    log.error(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: Table View Data
extension InventoryViewModel {
    
    var numberOfSections: Int { drinksViewModel.numberOfSections }
    func numberOfRows(inSection section: Int) -> Int { drinksViewModel.numberOfRows(inSection: section) }
    func titleForHeaderInSection(_ section: Int) -> String { drinksViewModel.titleForHeaderInSection(section) }
}

// MARK: Helper Model
class InventoryDrink {
    let type: DrinkType
    let drinkName: String
    var quantity: Int
    
    init(type: DrinkType, drinkName: String, quantity: Int) {
        self.type = type
        self.drinkName = drinkName
        self.quantity = quantity
    }
}
