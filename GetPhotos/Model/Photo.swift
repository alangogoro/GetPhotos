//
//  File.swift
//  GetPhotos
//
//  Created by usr on 2020/9/1.
//  Copyright © 2020 usr. All rights reserved.
//

import Foundation

struct Photo: Codable {
    var id:    Int
    var title: String
    var url: URL
    var thumbnailUrl: URL
}
