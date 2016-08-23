//
//  MarvelCharacter.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 22.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import UIKit

protocol CellDisplayable {
    var mainTitle: String { get }
    var subtitle: String { get }
}

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

extension MarvelCharacter: CellDisplayable {
    
    var mainTitle: String {
        return name ?? ""
    }
    
    var subtitle: String {
        return description ?? ""
    }
}

extension MarvelCharacter {
    
    var single: Resource<MarvelCharacter> {
        let url = MarvelURL(urlString: "http://gateway.marvel.com:80/v1/public/characters/\(id)")
        return Resource(url: url.authorized(), parse: parseCharacter)
    }
    
    static var all: Resource<[MarvelCharacter]> {
        let url = MarvelURL(urlString: "http://gateway.marvel.com:80/v1/public/characters")
        return Resource(url: url.authorized(), parse: parseCharacters)
    }
    
    private func parseCharacter(dict: JSONDictionary) -> MarvelCharacter? {
        return MarvelCharacter.parsedCharacterData(from: MarvelDict(dict).unwrapped()?.first) ?? nil
    }
    
    private static func parseCharacters(dict: JSONDictionary) -> [MarvelCharacter]? {
        var array = [MarvelCharacter]()
        MarvelDict(dict).unwrapped()?.forEach { json in
            if let char = parsedCharacterData(from: json) {
                array.append(char)
            }
        }
        return array.count > 0 ? array : nil
     }
    
    private static func parsedCharacterData(from dict: JSONDictionary?) -> MarvelCharacter? {
        guard
            let dict = dict,
            let id = dict["id"] as? Int,
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
}
