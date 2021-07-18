//
//  Injection.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import RealmSwift
import Core
import Recipe
import UIKit

class Injection {
    
    func provideCategory<U: UseCase>() -> U where U.Request == Any, U.Response == [RecipeDomainModel] {
        // 2
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
        // 3
        let locale = GetRecipeLocalDataSource(realm: appDelegate.realm)
            
        // 4
        let remote = GetRecipesRemoteDataSource(endPoint: EndPoints.Gets.randomMenu.url)
            
        // 5
        let mapper = RecipeTransformer()
            
        // 6
        let repository = GetCategoriesRepository(
            localDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
            
        // 7
        return Interactor(repository: repository) as! U
    }
    
    
    
    func provideRepository() -> FoodieRepositoryProtocol {
        
        let realm: Realm? = try? Realm()
        
        let remoteDataSource: RemoteDatasource = RemoteDatasource.sharedRemoteDatasourceInstance
        let localDataSource: LocalDatasource = LocalDatasource.sharedInstance(realm)
        
        
        return FoodieRepository(remoteDataSource: remoteDataSource, localeDataSource: localDataSource)
    }
    
    func provideHomeUseCase()-> HomeUseCase {
        
        let repository = provideRepository()
    
        return HomeInteractor(repositoryProtocol: repository)
    }
    
    
    
    
}
