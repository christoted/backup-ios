//
//  HomePresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import Combine
import UIKit
import Core
import Recipe

class HomePresenter: ObservableObject {
  
    private let useCase: Interactor<Any, [RecipeDomainModel], GetCategoriesRepository<GetRecipeLocalDataSource, GetRecipesRemoteDataSource, RecipeTransformer>>
    var homeRouter:HomeRouter?
    var homeView: UIViewController?
    
    init(useCase: Interactor<Any, [RecipeDomainModel], GetCategoriesRepository<GetRecipeLocalDataSource, GetRecipesRemoteDataSource, RecipeTransformer>>, homeRouter: HomeRouter) {
        self.useCase = useCase
        self.homeRouter = homeRouter
    }
    
}
