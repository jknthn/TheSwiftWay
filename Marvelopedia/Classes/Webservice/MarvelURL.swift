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

extension String {
    
    var md5: String {
        let str = self.cString(using: .utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        return String(format: hash as String)
    }
}
