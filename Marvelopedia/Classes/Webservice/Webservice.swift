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
        let task = URLSession.shared.dataTask(with: resource.url) { data, _, _ in
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            completion(.success(resource.parse(data)!))
        }
        task.resume()
    }
}
