//
//  HomeRouter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 17/06/21.
//

import Foundation
import UIKit
import Core
import Recipe
import Combine

//Implement with Protocol Delegate
protocol HomeRouterDelegate  {
    func createHomeModule()->UIViewController
}

class HomeRouter: HomeRouterDelegate {
    
    func createHomeModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        
        let recipeUseCase: Interactor<Any, [RecipeDomainModel], GetCategoriesRepository<GetRecipeLocalDataSource, GetRecipesRemoteDataSource, RecipeTransformer>> = Injection().provideCategory()

        let presenter = GetListPresenter(useCase: recipeUseCase)
        homeVC.presenter = presenter
        return homeVC
    }
    
    func navigateToDetailModule()->DetailPresenter {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailRecipeViewController") as DetailRecipeViewController
        
        let detailUseCase = Injection().provideHomeUseCase()
        let presenter = DetailPresenter(useCase: detailUseCase)
        
        detailVC.presenter = presenter
        detailVC.presenter?.router = HomeRouter()
        detailVC.presenter?.detailView = detailVC
        
        return presenter
    }
    
    
}
