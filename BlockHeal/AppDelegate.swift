//
//  AppDelegate.swift
//  BlockHeal
//
//  Created by ali on 5/19/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import UIKit
import SwiftyBeaver


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let log = SwiftyBeaver.self
        // log to Xcode Console
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss$d $L $M"
        // To Cloud
        let cloud = SBPlatformDestination(appID: "1P9bB9", appSecret: "lnsjjfxpnMljksa9cckKzpqf74tcnfze", encryptionKey: "bqxRhsiidZp9Lbk9sjbkx12uyvrxkzmz")

        log.addDestination(console)
        log.addDestination(cloud)
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

