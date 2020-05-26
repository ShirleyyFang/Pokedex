//
//  UserTableViewController.swift
//  Stonks_finalproject
//
//  Created by Yanbing Fang on 5/14/20.
//  Copyright © 2020 Yanbing Fang. All rights reserved.
//

import UIKit
import CoreData

class UserTableViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()
        print("**",itemArray.count)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let pokeCell = tableView.dequeueReusableCell(withIdentifier: "userPokeMon", for: indexPath) as? UserTableViewCell {
            pokeCell.configureTableCell(item: itemArray[indexPath.row])
            cell = pokeCell
        }
        return cell
    }
    
    func loadItem(with request:NSFetchRequest<Item> = Item.fetchRequest()){
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            itemArray = try context.fetch(request)
            print(itemArray.count)
        }catch {
        }
        tableView.reloadData()
    }
    
//delete the cell
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            //delete from core data
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(itemArray[indexPath.row])
            self.itemArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
