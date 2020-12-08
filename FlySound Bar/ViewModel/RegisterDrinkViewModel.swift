//
//  Created by Edward Nagy on 09/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation

final class RegisterDrinkViewModel {

    private var context = CoreDataStack.shared.managedObjectContext

    func registerDrink(_ drinkData: DrinkData) {
        let drink = Drink(context: context)
        drink.type = drinkData.type.rawValue
        drink.name = drinkData.drinks[0]

        do {
            try context.save()
            log.info("Saved Drink: \(drink.name ?? "-")")
        } catch(let error) {
            log.error(error.localizedDescription)
        }
    }

    // MARK: Function needed JUST IN CASE
    func registerPredefinedDrinks() {
        let drinks: [DrinkData] = [DrinkData(type: .longDrinks, drinks: ["Vodka Apple/Cranberry/Orange"]),
                                   DrinkData(type: .longDrinks, drinks: ["Vodka Energy"]),
                                   DrinkData(type: .longDrinks, drinks: ["Whisky Apple/Cola"]),
                                   DrinkData(type: .longDrinks, drinks:  ["Whisky Energy"]),
                                   DrinkData(type: .longDrinks, drinks:  ["Gin Tonic/Cranberry"]),
                                   DrinkData(type: .longDrinks, drinks:  ["Cuba Libre"]),
                                   DrinkData(type: .longDrinks, drinks:  ["Jagger Bomb/Cranberry"]),
                                   DrinkData(type: .beer, drinks: ["Tuborg 0.33"]),
                                   DrinkData(type: .shots, drinks: ["Blue Kamikaze"]),
                                   DrinkData(type: .shots, drinks: ["Red Kamikaze"]),
                                   DrinkData(type: .softDrinks, drinks: ["Coca Cola"]),
                                   DrinkData(type: .softDrinks, drinks:  ["Orange Juice"]),
                                   DrinkData(type: .softDrinks, drinks:   ["Apple Juice"]),
                                   DrinkData(type: .softDrinks, drinks:   ["Hell Energy Drink"]),
                                   DrinkData(type: .others, drinks: ["Vodka 50ML"]),
                                   DrinkData(type: .others, drinks: ["Whisky 50ML"]),
                                   DrinkData(type: .others, drinks: ["Gin 50ML"]),
                                   DrinkData(type: .others, drinks: ["Rom 50ML"])]
        drinks.forEach { registerDrink($0) }
    }
}

// MARK: Picker Data
extension RegisterDrinkViewModel {

    var numberOfComponentsInPicker: Int { 1 }
    var numberOfRowsInPicker: Int { DrinkType.allCases.count }
    func titleForRowInPicker(_ row: Int) -> String {
        DrinkType.allCases.first(where: { $0.index == row })?.rawValue ?? ""
    }
}
