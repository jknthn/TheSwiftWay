//
//  Webservice.swift
//  Marvelopedia
//
//  Created by Jeremi Kaczmarczyk on 22.08.2016.
//  Copyright © 2016 Jeremi Kaczmarczyk. All rights reserved.
//

import Foundation

class Webservice {
    
    func get<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> Void) {
        let task = URLSession.shared.dataTask(with: resource.url) { data, _, error in
            
            if let error = error {
                completion(.failure(APIError.fromError(error: error as NSError)))
            }
            
            guard
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? JSONDictionary
            else {
                fatalError("Something is wrong.")
                return
            }
            
            if let error = self.checkDictForError(jsonDict) {
                return completion(.failure(error))
            }
            completion(.success(resource.parse(jsonDict)!))
        }
        task.resume()
    }
    
    private func checkDictForError(_ dict: JSONDictionary) -> Error? {
        guard let errorCode = dict["code"] as? Int else {
            return nil
        }
        return APIError(rawValue: errorCode) ?? .unknown
    }
}
