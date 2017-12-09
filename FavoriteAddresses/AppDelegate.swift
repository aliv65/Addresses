//
//  AppDelegate.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 05.12.2017.
//  Copyright © 2017 Aleksander Ivanin. All rights reserved.
//

import UIKit
import MagicalRecord
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    fileprivate var storageName = "FavoriteAddresses.sqlite"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
        
        self.setupStorage()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = BaseNavigationController(rootViewController: StartViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

// MARK: - Persistens configuration
extension AppDelegate {
    fileprivate func setupStorage(){
        MagicalRecord.setLoggingLevel(.error)
        MagicalRecord.setShouldDeleteStoreOnModelMismatch(true)
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: self.storageName)
    }
}

