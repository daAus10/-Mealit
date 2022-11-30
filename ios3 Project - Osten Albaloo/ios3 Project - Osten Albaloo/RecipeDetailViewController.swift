//
//  RecipeDetailViewController.swift
//  ios3 Project - Osten Albaloo
//
//  Created by Austin Albaloo on 2022-10-26.
//

import Foundation
import UIKit

class RecipeDetailViewController: UIViewController{
    var recipeResults = [Recipe]()
    lazy var coreDataStack = CoreDataStack(modelName: "CoreData Model")
    var recipeList = [CoreEntity]()

    var recipeData: Recipe!
    //MARK: Outlets
    
    @IBAction func favButton(_ sender: Any) {
        addToFav()
    }
    
    @IBOutlet weak var RecipeImage2: UIImageView!
    @IBOutlet weak var recipeName2: UILabel!
    @IBOutlet weak var instructionsText: UILabel!
    
    @IBOutlet weak var ingredientsText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipe = recipeData{

            
            recipeName2.text = recipe.strMeal
       
            //self.RecipeImage2 = recipeData.strMealThumb
            instructionsText.text = recipe.strInstructions
            
           ingredientsText.text = "\(recipe.strMeasure1)"+"  "+"\(recipe.strIngredient1) \n" +
            "\(recipe.strMeasure2) "+"  "+" \(recipe.strIngredient2) \n" +
            "\(recipe.strMeasure3) "+"  "+" \(recipe.strIngredient3) \n" +
            "\(recipe.strMeasure4) "+"  "+" \(recipe.strIngredient4) \n" +
            "\(recipe.strMeasure5) "+"  "+" \(recipe.strIngredient5) \n" +
            "\(recipe.strMeasure6) "+"  "+" \(recipe.strIngredient6) \n" +
            "\(recipe.strMeasure7) "+"  "+" \(recipe.strIngredient7) \n" +
            "\(recipe.strMeasure8) "+"  "+" \(recipe.strIngredient8) \n" +
            "\(recipe.strMeasure9) "+"  "+" \(recipe.strIngredient9) \n" +
            "\(recipe.strMeasure10) "+"  "+" \(recipe.strIngredient10) \n" +
            "\(recipe.strMeasure11) "+"  "+" \(recipe.strIngredient11) \n" +
            "\(recipe.strMeasure12) "+"  "+" \(recipe.strIngredient12) \n" +
            "\(recipe.strMeasure13) "+"  "+" \(recipe.strIngredient13) \n" +
            "\(recipe.strMeasure14) "+"  "+" \(recipe.strIngredient14) \n" +
            "\(recipe.strMeasure15) "+"  "+" \(recipe.strIngredient15)" +
            "\n\(recipe.strMeasure16) "+"  "+" \(recipe.strIngredient16)" +
            "\n\(recipe.strMeasure17) "+"  "+" \(recipe.strIngredient17)" +
            "\n\(recipe.strMeasure18) "+"  "+" \(recipe.strIngredient18)" +
            "\n\(recipe.strMeasure19) "+"  "+" \(recipe.strIngredient19)" +
            "\n\(recipe.strMeasure20) "+"  "+" \(recipe.strIngredient20)"
            if let recipeImage = recipe.strMealThumb{
                fetchRecipeImage(for: recipeImage)
            }
        }
    }
    func fetchRecipeImage(for imagePath: String){
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
                    self.RecipeImage2.image = image
                }
            }
        }
        //continue fetching
        imageFetching.resume()
    }
    func addToFav(){
        let alert = UIAlertController(title: "Added", message: "This \(recipeName2.text ?? "") recipe is added to favourites.", preferredStyle: .alert)

               // add an action (button)
               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))

               // show the alert
        self.present(alert, animated: true)
       // print(recipeData)
        if let recipeData = recipeData{
            
            let newFacouriteRecipe = CoreEntity(context: self.coreDataStack.managedContext)
            //add values to the entity's properties
            
            newFacouriteRecipe.name = recipeData.strMeal
            newFacouriteRecipe.picture = recipeData.strMealThumb!
            newFacouriteRecipe.instructs = recipeData.strInstructions
            newFacouriteRecipe.ingreds = "\(recipeData.strMeasure1)"+"  "+"\(recipeData.strIngredient1) \n" +
            "\(recipeData.strMeasure2) "+"  "+" \(recipeData.strIngredient2) \n" +
            "\(recipeData.strMeasure3) "+"  "+" \(recipeData.strIngredient3) \n" +
            "\(recipeData.strMeasure4) "+"  "+" \(recipeData.strIngredient4) \n" +
            "\(recipeData.strMeasure5) "+"  "+" \(recipeData.strIngredient5) \n" +
            "\(recipeData.strMeasure6) "+"  "+" \(recipeData.strIngredient6) \n" +
            "\(recipeData.strMeasure7) "+"  "+" \(recipeData.strIngredient7) \n" +
            "\(recipeData.strMeasure8) "+"  "+" \(recipeData.strIngredient8) \n" +
            "\(recipeData.strMeasure9) "+"  "+" \(recipeData.strIngredient9) \n" +
            "\(recipeData.strMeasure10) "+"  "+" \(recipeData.strIngredient10) \n" +
            "\(recipeData.strMeasure11) "+"  "+" \(recipeData.strIngredient11) \n" +
            "\(recipeData.strMeasure12) "+"  "+" \(recipeData.strIngredient12) \n" +
            "\(recipeData.strMeasure13) "+"  "+" \(recipeData.strIngredient13) \n" +
            "\(recipeData.strMeasure14) "+"  "+" \(recipeData.strIngredient14) \n" +
            "\(recipeData.strMeasure15) "+"  "+" \(recipeData.strIngredient15)" +
            "\n\(recipeData.strMeasure16) "+"  "+" \(recipeData.strIngredient16)" +
            "\n\(recipeData.strMeasure17) "+"  "+" \(recipeData.strIngredient17)" +
            "\n\(recipeData.strMeasure18) "+"  "+" \(recipeData.strIngredient18)" +
            "\n\(recipeData.strMeasure19) "+"  "+" \(recipeData.strIngredient19)" +
            "\n\(recipeData.strMeasure20) "+"  "+" \(recipeData.strIngredient20)"
            
            self.coreDataStack.saveContext()
            
            //add to array
             recipeList.append(newFacouriteRecipe)
            print(recipeList)
        }
        
    }
}

