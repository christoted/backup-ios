//
//  File.swift
//  
//
//  Created by Christopher Teddy  on 16/07/21.
//

import Foundation

public struct Responses: Codable {
    let result: [RandomMenuResponse]
    let offset: Int?
    let number: Int?
    let totalResults: Int?
    
    private enum CodingKeys: String, CodingKey {
        case result = "results"
        case offset = "offset"
        case number = "number"
        case totalResults = "totalResults"
    }
}
