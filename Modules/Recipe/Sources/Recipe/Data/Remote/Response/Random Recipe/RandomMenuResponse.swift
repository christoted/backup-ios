//
//  File.swift
//  
//
//  Created by Christopher Teddy  on 16/07/21.
//

import Foundation

public struct RandomMenuResponse: Codable {
    let id:Int?
    let title: String?
    let image: String?
    let imageType: String?
    let nutrition: Nutrients
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case image = "image"
        case imageType = "imageType"
        case nutrition = "nutrition"
    }
   
}

public struct Nutrients: Codable {
    let nutrients: [NutrientsResponse]
    
    private enum CodingKeys: String, CodingKey {
        case nutrients = "nutrients"
    }
}

public struct NutrientsResponse: Codable {
    let title: String?
    let amount: Double?
    var unit: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case amount = "amount"
        case unit = "unit"
    }
}
