//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Andrea on 28/05/2019.
//  Copyright © 2019 Andrea P. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {


    var categoryList = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        loadCategoryList()
        
    }
    
    func loadCategoryList() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
        categoryList = try context.fetch(request)
        } catch {
            print("Error loading category list \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let itemCategory = categoryList[indexPath.row]
        
        cell.textLabel?.text = categoryList[indexPath.row].name
        
        
        return cell
        
        
    }
    
      //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
       if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryList[indexPath.row]
        }
    }
    
    //MARK: - TableView Manipulation Methods
    
    func saveCategoryList() {
        do {
        try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }



        //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "<#T##String?#>", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryList.append(newCategory)
            
            self.saveCategoryList()
            
        }
            
            alert.addAction(action)
            
            alert.addTextField { (field) in
                
                textField = field
                textField.placeholder = "Add a new category"
                
            }
                
                self.present(alert, animated: true, completion: nil)
        
        }
    }
    

    
    

    
    

