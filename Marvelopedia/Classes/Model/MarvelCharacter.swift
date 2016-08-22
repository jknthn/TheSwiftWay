//
//  MarvelCharacter.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 22.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String: AnyObject]

struct MarvelCharacter {
    
    let id: Int
    private(set) var name: String?
    private(set) var description: String?
    private(set) var thumbnailURL: URL?
    
    init(id: Int, name: String? = nil, description: String? = nil, thumbnailURL: URL? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnailURL = thumbnailURL
    }
}

extension MarvelCharacter {
    
    var single: Resource<MarvelCharacter> {
        let url = MarvelURL(urlString: "http://gateway.marvel.com:80/v1/public/characters/\(id)")
        return Resource(url: url.authorized(), parse: parseCharacter)
    }
    
    private func parseCharacter(data: Data) -> MarvelCharacter? {
        return parseCharacterData(from: unwrapCharacterData(from: data)) ?? nil
    }
    
    private func parseCharacterData(from dict: JSONDictionary?) -> MarvelCharacter? {
        guard
            let dict = dict,
            let name = dict["name"] as? String,
            let description = dict["description"] as? String,
            let thumbnail = dict["thumbnail"] as? JSONDictionary,
            let thumbnailString = thumbnail["path"] as? String,
            let thumbnailURL = URL(string: thumbnailString)
        else {
                fatalError("Parsing error. It is on programmer.")
                return nil
        }
        
        return MarvelCharacter(id: id, name: name, description: description, thumbnailURL: thumbnailURL)
    }
    
    private func unwrapCharacterData(from data: Data) -> JSONDictionary? {
        guard
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONDictionary,
            let data = json?["data"] as? JSONDictionary ,
            let results = data["results"] as? [JSONDictionary],
            let characterData = results.first
        else {
            fatalError("Parsing error. It is on programmer.")
            return nil
        }
        return characterData
    }
}
