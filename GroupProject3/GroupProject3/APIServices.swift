//
//  APIServices.swift
//  GroupProject3
//
//  Created by Kato on 6/19/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import UIKit

class APIServices {
    static func decode(file: String,completion: @escaping (List)->()){
        guard let url = URL(string: file) else {return}
        URLSession.shared.dataTask(with: url){(data,res,err)in
            guard let data = data else {return}
            do{
                let decode = JSONDecoder()
                let response = try decode.decode(List.self, from: data)
                completion(response)
            }catch{ print(error.localizedDescription)}
        }.resume()
    }
}
// MARK: - List
struct List: Codable {
    let objects: [Object]
}
// MARK: - Object
struct Object: Codable {
    let id, cityID, objectID, objectTypeID: String
    let bankID, nameGe, nameEn, nameRu: String
    let tel, addressGe, addressRu, addressEn: String
    let latitude, longtitude, noteGe, noteRu: String
    let noteEn, isActive, position, updateDate: String
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case cityID = "city_id"
        case objectID = "object_id"
        case objectTypeID = "object_type_id"
        case bankID = "bank_id"
        case nameGe = "name_ge"
        case nameEn = "name_en"
        case nameRu = "name_ru"
        case tel
        case addressGe = "address_ge"
        case addressRu = "address_ru"
        case addressEn = "address_en"
        case latitude, longtitude
        case noteGe = "note_ge"
        case noteRu = "note_ru"
        case noteEn = "note_en"
        case isActive = "is_active"
        case position
        case updateDate = "update_date"
    }
}

