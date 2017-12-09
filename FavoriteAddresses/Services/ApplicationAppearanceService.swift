//
//  ApplicationAppearanceService.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 09.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import PluggableApplicationDelegate

final class ApplicationAppearanceService: NSObject, ApplicationService {
    var window: UIWindow?
     
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = BaseNavigationController(rootViewController: SavedAddressesViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}
