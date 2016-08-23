//
//  MarvelDict.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 23.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

struct MarvelDict {
    
    let dict: JSONDictionary
    
    init(_ dict: JSONDictionary) {
        self.dict = dict
    }
    
    func unwrapped() -> [JSONDictionary]? {
        guard
            let data = dict["data"] as? JSONDictionary,
            let results = data["results"] as? [JSONDictionary]
        else {
            fatalError("Parsing error. It is on programmer.")
            return nil
        }
        return results
    }
}
