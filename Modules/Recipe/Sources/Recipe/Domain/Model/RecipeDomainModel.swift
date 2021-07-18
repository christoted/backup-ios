//
//  File.swift
//  
//
//  Created by Christopher Teddy  on 16/07/21.
//

import Foundation


public struct RecipeDomainModel {
   
    public let id:Int?
    public let title: String?
    public let image: String?
    public let imageType: String?
    public let nutrition: [NutrientDomainModel]
    
    //Addition
    public let summary: String?
    public let extendedIngridients: [IngridientDomainModel]?
    
    public let isBookmarked: Bool?
    
    public init(id: Int, title: String, image:String, imageType: String, nutrition: [NutrientDomainModel], summary: String, extendedIngridients: [IngridientDomainModel], isBookmarked: Bool) {
        self.id = id
        self.title = title
        self.image = image
        self.imageType = imageType
        self.nutrition = nutrition
        self.summary = summary
        self.extendedIngridients = extendedIngridients
        self.isBookmarked = isBookmarked
    }
    
}

public struct NutrientDomainModel  {
    public let title: String?
    public let amount: Double?
    public let unit: String?
    
}


public struct IngridientDomainModel {
    public let id: Int?
    public let asile: String?
    public  let name: String?
    public let original: String?
    public let unit: String?
}

