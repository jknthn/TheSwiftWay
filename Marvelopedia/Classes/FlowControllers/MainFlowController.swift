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
        rootController = UIViewController()
        rootController.view.backgroundColor = #colorLiteral(red: 0.08369787037, green: 0.212726444, blue: 0.3254130781, alpha: 1)
        rootNavigation.addChildViewController(rootController)
    }
}
