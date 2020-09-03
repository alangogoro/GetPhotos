//
//  PhotoController.swift
//  GetPhotos
//
//  Created by usr on 2020/9/1.
//  Copyright © 2020 usr. All rights reserved.
//

import Foundation

struct PhotoController {
    static let shared = PhotoController()
    var baseRequest = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/photos")!)
    
    func fetchPhotos(completionHandler: @escaping([Photo]?) -> Void) {
        var request = baseRequest
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(String(describing: error))
            }
            let decoder = JSONDecoder()
            if let data = data, let photos = try? decoder.decode([Photo].self, from: data) {
                completionHandler(photos)
            } else {
                completionHandler(nil)
            }
        }.resume()
    }
}
