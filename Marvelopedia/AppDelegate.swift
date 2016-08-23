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
    
    lazy var mainFlowController = MainFlowController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupWindow()
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainFlowController.rootNavigation
    }
}
