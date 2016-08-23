//
//  String+MD5.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 23.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import Foundation

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
