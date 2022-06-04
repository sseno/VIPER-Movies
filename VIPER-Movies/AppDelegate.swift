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
        
        if #available(iOS 15.0, *) {
            UITableView.appearance().tableHeaderView = .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        }
            
        window = UIWindow()
        window?.rootViewController = GenresRouter.createModule()
        window?.makeKeyAndVisible()
        return true
    }

}

