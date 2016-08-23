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
        
        let menuViewModel = MenuViewModel(menuOptions: [.heroes, .events])
        rootController = MenuViewController(menuViewModel:
            menuViewModel
        )
        menuViewModel.delegate = self
        rootNavigation.addChildViewController(rootController)
    }
}

extension MainFlowController: MenuViewModelDelegate {
    
    func menuViewModel(menuViewModel: MenuViewModel, didSelectOption option: MenuOption) {
        let vc = HeroesViewController()
        vc.title = option.rawValue.uppercased()
        vc.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        switch option {
        case .heroes:
            rootNavigation.pushViewController(vc, animated: true)
        case .events:
            rootNavigation.pushViewController(vc, animated: true)
        }
    }
}
