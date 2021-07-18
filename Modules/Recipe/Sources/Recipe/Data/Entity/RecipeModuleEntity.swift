//
//  File.swift
//  
//
//  Created by Christopher Teddy  on 16/07/21.
//

import Foundation

import RealmSwift

public class RecipeModuleMenuEntity: Object {
    @objc dynamic var id:Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var imageType: String = ""
    @objc dynamic var isBookmarked: Bool = false
    
    var nutrition: [NutrientsEntity] = []
    
    //var nutrition = List<NutrientsEntity>()
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
    //Addition
    @objc dynamic var summary: String = ""
    
 //   var extendedIngredients: [IngridientEntity] = []
    
    var extendedIngredients = List<IngridientEntity>()
    
}


public class NutrientsEntity: Object  {
    @objc dynamic var title: String = ""
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var unit: String = ""
    
}

public class IngridientEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var asile: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var original: String = ""
    @objc dynamic var unit: String = ""
}

