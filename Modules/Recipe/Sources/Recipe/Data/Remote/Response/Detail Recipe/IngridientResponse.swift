//
//  File.swift
//  
//
//  Created by Christopher Teddy  on 16/07/21.
//

import Foundation

public struct IngridientResponse: Codable {
    let id: Int?
    let asile: String?
    let name: String?
    let original: String?
    let unit: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case asile = "asile"
        case name = "name"
        case original = "original"
        case unit = "unit"
    }
    
}
