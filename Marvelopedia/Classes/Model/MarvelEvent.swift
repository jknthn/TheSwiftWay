//
//  MarvelEvent.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 23.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import Foundation

struct MarvelEvent {
    
    let id: Int
    private(set) var title: String?
    private(set) var description: String?
    
    
    init(id: Int, title: String? = nil, description: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
    }
}

extension MarvelEvent: CellDisplayable {
    
    var mainTitle: String {
        return title ?? ""
    }
    
    var subtitle: String {
        return description ?? ""
    }
}

extension MarvelEvent {
    
    static var all: Resource<[MarvelEvent]> {
        let url = MarvelURL(urlString: "http://gateway.marvel.com:80/v1/public/events")
        return Resource(url: url.authorized(), parse: parseEvents)
    }
    
    private static func parseEvents(dict: JSONDictionary) -> [MarvelEvent]? {
        var array = [MarvelEvent]()
        MarvelDict(dict).unwrapped()?.forEach { json in
            if let event = parsedEventData(from: json) {
                array.append(event)
            }
        }
        return array.count > 0 ? array : nil
    }
    
    private static func parsedEventData(from dict: JSONDictionary?) -> MarvelEvent? {
        guard
            let dict = dict,
            let id = dict["id"] as? Int,
            let title = dict["title"] as? String,
            let description = dict["description"] as? String
        else {
            fatalError("Parsing error. It is on programmer.")
            return nil
        }
        
        return MarvelEvent(id: id, title: title, description: description)
    }
}
