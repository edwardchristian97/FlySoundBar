//
//  Created by Edward Nagy on 09/09/2020.
//  Copyright © 2020 Nagy Edward Christian. All rights reserved.
//

import Foundation

public class DataManagementViewModel {

    private let key = "FirstLaunch"
    private let domainStorage = UserDefaults.standard
    private let drinksViewModel = RegisterDrinkViewModel()

    public var isFirstLaunch: Bool {
        let launchedBefore = domainStorage.bool(forKey: key)
        if !launchedBefore {
            domainStorage.set(true, forKey: key)
            log.info("User is launching the app for the first time")
            return true
        }
        return false
    }

    public func registerPredefinedDrinks() {
        drinksViewModel.registerPredefinedDrinks()
    }
}
