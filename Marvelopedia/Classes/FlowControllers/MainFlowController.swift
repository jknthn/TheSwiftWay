//
//  MainFlowController.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 10.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import UIKit

class MainFlowController: FlowController {
    
    let rootNavigation: UINavigationController
    let rootController: UIViewController
    
    init() {
        rootNavigation = UINavigationController()
        rootController = MenuViewController()
        rootNavigation.addChildViewController(rootController)
    }
}
