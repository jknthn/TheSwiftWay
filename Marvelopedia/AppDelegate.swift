//
//  AppDelegate.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 10.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupWindow()
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let ctrl = UIViewController()
        ctrl.view.backgroundColor = #colorLiteral(red: 0.1142767668, green: 0.3181744218, blue: 0.4912756383, alpha: 1)
        window?.rootViewController = ctrl
    }
}

