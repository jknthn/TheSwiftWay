//
//  MarvelURL.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 22.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import Foundation

struct MarvelURL {
    private let ts = Int(Date().timeIntervalSinceReferenceDate)
    private let privateKey = Bundle.main.object(forInfoDictionaryKey: "MarvelPrivateKey")!
    private let publicKey = "3e2e1997fd3ada9d85d651c8627d1052"
    
    let urlString: String
    
    func authorized() -> URL {
        let timeStamp = "ts=\(ts)"
        let apiKey = "apikey=" + publicKey
        let hash = "hash=" + "\(ts)\(privateKey)\(publicKey)".md5
        
        let authorizedString = urlString + "?" + [timeStamp, apiKey, hash].joined(separator: "&")
        
        guard let url = URL(string: authorizedString) else {
            fatalError("Programer error")
        }
        return url
    }
}
