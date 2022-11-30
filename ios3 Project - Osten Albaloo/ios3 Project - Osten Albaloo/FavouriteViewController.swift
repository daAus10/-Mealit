//
//  FavouriteViewController.swift
//  ios3 Project - Osten Albaloo
//
//  Created by Austin Albaloo on 2022-11-08.
//

import Foundation
import UIKit
import CoreData
class favouriteViewController: UIViewController{
    //MARK: Outlets

    @IBOutlet weak var favTable: UITableView!
    lazy var coreDataStack = CoreDataStack(modelName: "CoreData Model")
    
    //create an array of recipes
    var recipeList = [CoreEntity]()
    override func viewDidLoad() {
        super.viewDidLoad()
        favTable.delegate = self
        favTable.dataSource = self
        fetchSavedRecipes()
    }
    func fetchSavedRecipes(){
        let fetchRequest: NSFetchRequest<CoreEntity> = CoreEntity.fetchRequest()
        do {
            recipeList = try coreDataStack.managedContext.fetch(fetchRequest)
        } catch {
            print("Problem fetching to do items: \(error)")
        }
    }
    
}

extension favouriteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            //determine what was selected
            let selected = recipeList[indexPath.row]
            
            //remove from coreData
            coreDataStack.managedContext.delete(selected)
            //save the context
            coreDataStack.saveContext()
            
            //remove from the todolist array
            recipeList.remove(at: indexPath.row)
            //remove from the current tableview
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        default:
            break
        }
    }
    
}

extension favouriteViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        let item = recipeList[indexPath.row]
        
        cell.textLabel?.text = item.name

        return cell
    }
}

