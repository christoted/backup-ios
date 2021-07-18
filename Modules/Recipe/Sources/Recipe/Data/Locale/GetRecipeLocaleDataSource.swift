//
//  File.swift
//  
//
//  Created by Christopher Teddy  on 16/07/21.
//

import Foundation
import Core
import Combine
import RealmSwift


public struct GetRecipeLocalDataSource: LocaleDataSource  {
    
    private let _realm: Realm
    
    public typealias Request = Any
    
    public typealias Response = RecipeModuleMenuEntity
    
    public init (realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[RecipeModuleMenuEntity], Error> {
        return Future<[RecipeModuleMenuEntity], Error> { completion in
            let recipes: Results<RecipeModuleMenuEntity> = {
                _realm.objects(RecipeModuleMenuEntity.self)
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            
            completion(.success(recipes.toArray(ofType: RecipeModuleMenuEntity.self)))
            
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [RecipeModuleMenuEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for recipe in entities {
                        _realm.add(recipe)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.databaseError))
            }
            
            
            
        }.eraseToAnyPublisher()
    }
    
    public func get(id: String) -> AnyPublisher<RecipeModuleMenuEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int, entity: RecipeModuleMenuEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
}
