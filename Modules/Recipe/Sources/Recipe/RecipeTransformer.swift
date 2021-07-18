//
//  File.swift
//  
//
//  Created by Christopher Teddy  on 16/07/21.
//

import Foundation
import Core

public struct RecipeTransformer: Mapper {
    
    public typealias Response = [RandomMenuResponse]
    
    public typealias Entity = [RecipeModuleMenuEntity]
    
    public typealias Domain = [RecipeDomainModel]
    
    public init () {}
    
    
    public func transformResponseToEntity(response: [RandomMenuResponse]) -> [RecipeModuleMenuEntity] {
        return response.map { randomMenuResponse in
            let recipeModuleMenuEntity = RecipeModuleMenuEntity()
            recipeModuleMenuEntity.id = randomMenuResponse.id ?? 0
            recipeModuleMenuEntity.image = randomMenuResponse.image ?? ""
            recipeModuleMenuEntity.imageType = randomMenuResponse.imageType ?? ""
            recipeModuleMenuEntity.title = randomMenuResponse.title ?? ""
            recipeModuleMenuEntity.isBookmarked = false
            recipeModuleMenuEntity.nutrition = randomMenuResponse.nutrition.nutrients.map { nutrient in
                let nutrientEntity = NutrientsEntity()
                nutrientEntity.title = nutrient.title ?? ""
                nutrientEntity.amount = nutrient.amount ?? 0
                nutrientEntity.unit = nutrient.unit ?? ""
                
                return nutrientEntity
            }
            
            return recipeModuleMenuEntity
        }
    }
    
    public func transformEntityToDomain(entity: [RecipeModuleMenuEntity]) -> [RecipeDomainModel] {
        return entity.map { modulEntity in
            let recipeDomainModel = RecipeDomainModel(id: modulEntity.id, title: modulEntity.title, image: modulEntity.image, imageType: modulEntity.imageType, nutrition: modulEntity.nutrition.map{ nutriont in
                return  NutrientDomainModel(title: nutriont.title, amount: nutriont.amount, unit: nutriont.unit)
            }, summary: "", extendedIngridients: [], isBookmarked: false)
            
            
            return recipeDomainModel
        }
    }
}
