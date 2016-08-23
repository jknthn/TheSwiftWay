//
//  MenuViewModel.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 23.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import Foundation

protocol MenuViewModelDelegate: class {
    func menuViewModel(menuViewModel: MenuViewModel, didSelectOption option: MenuOption)
}

enum MenuOption: String {
    case heroes
    case events
}

class MenuViewModel {
    
    let menuOptions: [MenuOption]
    
    weak var delegate: MenuViewModelDelegate?
    
    init(menuOptions: [MenuOption]) {
        self.menuOptions = menuOptions
    }
    
    func userTouchedOptionWithString(_ string: String) {
        if let option = MenuOption(rawValue: string.lowercased()) {
            delegate?.menuViewModel(menuViewModel: self, didSelectOption: option)
        }
    }
}
