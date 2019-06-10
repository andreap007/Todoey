//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Andrea on 28/05/2019.
//  Copyright © 2019 Andrea P. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categoryList: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        loadCategoryList()
        
    }
    
    func loadCategoryList() {
        
        categoryList = realm.objects(Category.self)
        
 
       tableView.reloadData()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let itemCategory = categoryList?[indexPath.row]
        
        cell.textLabel?.text = categoryList?[indexPath.row].name ?? "No category list added jet"
        
        return cell
        
        
    }
    
      //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
       if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryList?[indexPath.row]
        }
    }
    
    //MARK: - TableView Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
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
            
            let newCategory = Category()
            newCategory.name = textField.text!

            
            self.save(category: newCategory)
            
        }
            
            alert.addAction(action)
            
            alert.addTextField { (field) in
                
                textField = field
                textField.placeholder = "Add a new category"
                
            }
                
                self.present(alert, animated: true, completion: nil)
        
        }
    }
    

    
    

    
    

