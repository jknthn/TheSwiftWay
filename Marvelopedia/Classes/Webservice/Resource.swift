//
//  Resource.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 22.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}
