//
//  MenuItem.swift
//  ViperOcakbasi
//
//  Created by VAROL AKSOY on 22.12.2019.
//  Copyright © 2019 Varol AKSOY. All rights reserved.
//

import Foundation


struct MenuItem : Decodable {
let id : Int?
let name : String?
let type : String?
let duration : String?
let person : String?
let content : String?
let description : String?
let photo : String?
let created_at : String?
let updated_at : String?
let deleted_at : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case duration = "duration"
        case person = "person"
        case content = "content"
        case description = "description"
        case photo = "photo"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case deleted_at = "deleted_at"
    }
}

