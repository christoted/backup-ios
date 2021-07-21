//
//  ViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 18/05/21.
//

import UIKit
import Alamofire
import Combine
import Core
import Recipe

class HomeViewController: UIViewController {

    @IBOutlet weak var tvHome: UITableView!

    @IBOutlet weak var navigationItemHome: UINavigationItem!
    
    private var randomMenuOffline: [RecipeDomainModel] = []
    
    private var errorMessage: String = ""
    private var loadingState: Bool = false
    private var errorState: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    var presenter: GetListPresenter<
      Any, RecipeDomainModel, Interactor<
        Any, [RecipeDomainModel], GetCategoriesRepository<
          GetRecipeLocalDataSource, GetRecipesRemoteDataSource, RecipeTransformer
        >
      >
    >?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tvHome.dataSource = self
        tvHome.delegate = self
        
        navigationItemHome.title = "Foodiecipe"
    
        registerTableView()

        getCategories()
        
    }
    
    
  

    private func registerTableView() {
        tvHome.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homecell")
    }

    private func getCategories() {
        loadingState = true
        presenter?.$list.receive(on: RunLoop.main).sink { result in
            self.randomMenuOffline = result
            self.tvHome.reloadData()
        }.store(in: &cancellables)

        presenter?.$errorMessage.receive(on: RunLoop.main).sink { error in
            self.errorMessage = String(describing: error)
        }.store(in: &cancellables)

        presenter?.$isLoading.receive(on: RunLoop.main).sink { loading in
            self.loadingState = loading
        }.store(in: &cancellables)

        presenter?.$isError.receive(on: RunLoop.main).sink { error in
            self.errorState = error
        }.store(in: &cancellables)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomMenuOffline.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvHome.dequeueReusableCell(withIdentifier: "homecell") as! HomeTableViewCell

        let menu = randomMenuOffline[indexPath.row]
        
        let urlPath: String = menu.image!
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let url = URL(string: urlPath)
            
            let imageData = try? Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                cell.ivHome.image = UIImage(data: imageData!)
            }
            
        }
        
        
        
        cell.lblFoodId.text = "\(menu.id ?? 0)"
        cell.lblFoodName.text = menu.title
        
        

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "toDetail") {
            let dest = segue.destination as! DetailRecipeViewController
            let row = (sender as! NSIndexPath).row
            dest.recipeId = randomMenuOffline[row].id ?? 654812
//            let router: HomeRouter  = HomeRouter()
//            dest.presenter = router.navigateToDetailModule()
          //  dest.recipeIdNew = randomMenuOffline[row].id ?? 654812
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }

}

