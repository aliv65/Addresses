//
//  PersistensСonfigurationService.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 09.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import Foundation
import MagicalRecord
import PluggableApplicationDelegate

final class PersistensСonfigurationService: NSObject, ApplicationService {
    fileprivate var storageName = "FavoriteAddresses.sqlite"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.setupStorage()
        
        return true
    }
    
    fileprivate func setupStorage(){
        MagicalRecord.setLoggingLevel(.error)
        MagicalRecord.setShouldDeleteStoreOnModelMismatch(true)
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: self.storageName)
    }
}
