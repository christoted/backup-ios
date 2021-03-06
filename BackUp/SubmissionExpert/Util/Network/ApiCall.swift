//
//  ApiCall.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 18/05/21.
//

import Foundation

struct API {
    static let baseUrl = "https://api.spoonacular.com/"
    static let APIKEY = "e1f65dc5b65a4d2991aaee052f814b2b"
}

protocol EndPoint {
    var url: String { get  } 
}

public enum EndPoints {
    enum Gets: EndPoint {
        
        case searchByName(recipeName: String)
        case recipeInformation(recipeId: Int)
        case randomMenu
        
        
        public var url: String {
            switch self {
            
            case EndPoints.Gets.searchByName(let recipeName): return "\(API.baseUrl)recipes/complexSearch?query=\(recipeName)&maxFat=25&number=10&apiKey=\(API.APIKEY)"
                            
                
            case EndPoints.Gets.recipeInformation(let recipeId): return "\(API.baseUrl)recipes/\(recipeId)/information?includeNutrition=false&apiKey=\(API.APIKEY)"
                
            case EndPoints.Gets.randomMenu: return "\(API.baseUrl)recipes/complexSearch?query=pizza&maxFat=25&number=10&apiKey=\(API.APIKEY)"
           
        }
        
            
        }
    }
}
