//
//  Created by Edward Nagy on 09/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation

final class PartyDetailsViewModel {

    var party: Party? = nil
    private var context = CoreDataStack.shared.managedObjectContext
    private var paidDrinks: [PaidDrink] { fetchPaidDrinks().filter { $0.toParty == party } }
    private var paidDrinksToDisplay: [DrinkDTO] { display(paidDrinks: paidDrinks) }
}

// MARK: Functions
extension PartyDetailsViewModel {

    var paidDrinksTotal: Int64 { paidDrinks.reduce(0, { $0 + Int64(priceForType($1.type)) * $1.quantity }) }
    private func fetchPaidDrinks() -> [PaidDrink] {
        do {
            return try context.fetch(PaidDrink.fetchRequest())
        } catch {
            log.error(error.localizedDescription)
            return []
        }
    }

    private func priceForType(_ type: String?) -> Int {
        DrinkType.allCases.first(where: { $0.rawValue == type } )?.price ?? 0
    }

    func paidDrinkAt(index: Int) -> DrinkDTO {
        //paidDrinks[index]
        paidDrinksToDisplay[index]
    }

    func paidDrinkTotalAt(index: Int) -> Int64 {
        let paidDrink = paidDrinkAt(index: index)
        //let price = DrinkType.allCases.first(where: { $0.rawValue == paidDrink.type })?.price
        return paidDrink.quantity * paidDrink.price
    }

    private func isDrinkAdded(_ drink: String, inArray array: [DrinkDTO]) -> Bool {
        var isAdded = false
        array.forEach {
            if $0.name == drink {
                isAdded = true
            }
        }
        return isAdded
    }

    private func display(paidDrinks: [PaidDrink]) -> [DrinkDTO] {
        var array = [DrinkDTO]()
        paidDrinks.forEach { paidDrink in
            if !isDrinkAdded(paidDrink.name ?? "", inArray: array) {
                array.append(DrinkDTO(name: paidDrink.name ?? "", price: Int64(priceForType(paidDrink.type)), quantity: paidDrink.quantity))
            } else {
                array.forEach { drink in
                    if paidDrink.name == drink.name {
                        drink.quantity = drink.quantity + paidDrink.quantity
                    }
                }
            }
        }
        return array
    }
}

// MARK: Table View
extension PartyDetailsViewModel {

    var numberOfSections: Int { 1 }
    var numberOfRows: Int { paidDrinksToDisplay.count }
    var titleForHeader: String { "\(paidDrinksTotal) RON"}
}
