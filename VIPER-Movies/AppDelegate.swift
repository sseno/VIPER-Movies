//
//  AppDelegate.swift
//  VIPER-Movies
//
//  Created by Seno on 02/06/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.rootViewController = GenresRouter.createModule()
        window?.makeKeyAndVisible()
        return true
    }

}

