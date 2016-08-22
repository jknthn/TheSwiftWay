//
//  APIError.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 22.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import Foundation

enum APIError: Int, Error {
    case notFound = 404
    case unknown
    
    static func fromError(error: NSError) -> APIError {
        if let apiError = APIError(rawValue: error.code) {
            return apiError
        } else {
            return APIError.unknown
        }
    }
}
