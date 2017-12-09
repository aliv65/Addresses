//
//  AppDelegate.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 05.12.2017.
//  Copyright © 2017 Aleksander Ivanin. All rights reserved.
//

import UIKit
import PluggableApplicationDelegate

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {
    
    override var services: [ApplicationService] {
        return [
            PersistensСonfigurationService(),
            ApplicationAppearanceService()
        ]
    }
}

