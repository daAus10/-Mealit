//
//  RecipeTableViewCell.swift
//  ios3 Project - Osten Albaloo
//
//  Created by Austin Albaloo on 2022-10-09.
//

//import Foundation
import UIKit
class RecipeTableViewCell: UITableViewCell{
    var RecipeResults = [Recipe]()
    var recipeData: Recipe!

    lazy var coreDataStack = CoreDataStack(modelName: "CoreData Model")
    
    //create an array of recipes
    var recipeList = [CoreEntity]()
    
    @IBOutlet weak var yellowVIew: UIView!
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeCategory: UILabel!
    @IBOutlet weak var recipeOrigins: UILabel!
    
    
    @IBAction func favouriteButton(_ sender: Any) {
  //      showTextAlert()
    
    }
  
}
