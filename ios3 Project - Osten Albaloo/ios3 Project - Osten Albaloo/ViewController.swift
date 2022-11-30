//
//  ViewController.swift
//  ios3 Project - Osten Albaloo
//
//  Created by Austin Albaloo on 2022-10-06.
//

import UIKit


class ViewController: UIViewController {
    var recipeResults = [Recipe]()
    lazy var coreDataStack = CoreDataStack(modelName: "CoreData Model")
    //var recipeData: Recipe!
    //create an array of recipes
    var recipeList = [CoreEntity]()
    
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        tableView.dataSource = self
        
    }

    func apiURL(from input: String)-> URL?{
        //getting text from search bar
        let searchBarInput = input.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        //adding search bar text to the link
        let api = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(searchBarInput)"
        return URL(string: api)
    }
    
    //MARK: Fetching data from the API
    func fetchRecipeDetails(from url: URL, for searchValue: String){
        let Recipe = URLSession.shared.dataTask(with: url){
            data, response, error in
            // if there are errors show this...
            if let loadingErrors = error{
                print("Could not fetch recipes: \(loadingErrors.localizedDescription)")
                
            }else{
                do{
                    guard let givenData = data else{
                        return
                    }
                    //decoding the url and loading data using JSON decoder
                        let jsonDecoder = JSONDecoder()
                        let apiData = try jsonDecoder.decode(Recipes.self, from: givenData)
                    self.recipeResults = apiData.meals
                    print(self.recipeResults)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    //tey and catch decoding errors
                }catch DecodingError.keyNotFound(let Key, let context){
                    print("error key \(Key). content \(context)")
                }catch DecodingError.valueNotFound(let type, let context){
                    print("Error.. type: \(type). content \(context)")
                }catch let error{
                    print ("error decoding: \(error.localizedDescription)")
                }
            }
        }
        Recipe.resume()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  if segue.identifier == "passData"{
       if  let indexPath = self.tableView.indexPathForSelectedRow{
                let controller = segue.destination as? RecipeDetailViewController
            let selectedItem  = recipeResults[indexPath.row]
                controller?.recipeData = selectedItem
         //  controller?.recipeData = recipeData
     
           }
        
        
    }
    //MARK: Fetching Image
    func fetchRecipeImage(for imagePath: String, in cell: RecipeTableViewCell){
        guard let imageURL = URL(string: imagePath) else{
            print("Can't make url from \(imagePath)")
            return
        }
        //setting the fetched image from the API to the imageview named recipeImage
        let imageFetching = URLSession.shared.downloadTask(with: imageURL){
            url, response, error in
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                DispatchQueue.main.async{
                    //where to set the image
                    cell.recipeImage.image = image
                }
            }
        }
        //continue fetching
        imageFetching.resume()
    }

    
}
//MARK: Exitinsions

//search bar delegate extension
extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let Input = searchBar.text else{
            searchBar.resignFirstResponder()
            return
        }
        //get text from input to the url
        if let recipeURL = apiURL(from: Input){
            fetchRecipeDetails(from: recipeURL, for: Input)
            print(recipeURL)
        }
        
        searchBar.resignFirstResponder()
    }
}
//Table view delegate extension
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
   
        
        
    }
}

// sets each item in the cell to the information taken by the API
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return recipeResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //identifing cell to load.
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! RecipeTableViewCell
        
        let recipe = recipeResults[indexPath.row]
        //Setting all the info to all views..
        cell.recipeName.text = recipe.strMeal
        cell.recipeCategory.text = recipe.strCategory
        cell.recipeOrigins.text = recipe.strArea
        
        print(recipe)
        if let recipeImage = recipe.strMealThumb{
            fetchRecipeImage(for: recipeImage, in: cell)
        }
            
        return cell
    }
}
