//
//  FlowController.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 10.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import UIKit

protocol FlowController {
    var rootNavigation: UINavigationController { get }
    var rootController: UIViewController { get }
}
