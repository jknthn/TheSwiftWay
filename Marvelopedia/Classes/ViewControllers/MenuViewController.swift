//
//  MenuViewController.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 17.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Webservice().get(resource: MarvelCharacter(id: 1009368).single, completion: { rsr in
            print(rsr)
        })
    }
}
