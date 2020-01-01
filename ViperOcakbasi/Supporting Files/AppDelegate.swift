//
//  AppDelegate.swift
//  ViperOcakbasi
//
//  Created by VAROL AKSOY on 22.12.2019.
//  Copyright © 2019 Varol AKSOY. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        if let menuModule = MenuRouter.setupModule() {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = menuModule
            window?.makeKeyAndVisible()
            return true
        }

        return true
    }



}

