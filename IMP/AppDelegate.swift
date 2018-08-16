//
//  AppDelegate.swift
//  IMP
//
//  Created by Kare on 2018/8/12.
//  Copyright © 2018 kare. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        UIViewController.VCInit
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: ViewController(nibName: "ViewController", bundle: nil))
        nav.setNavigationBarHidden(true, animated: true)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }
}

