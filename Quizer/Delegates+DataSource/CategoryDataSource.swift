//
//  CategoryDataSource.swift
//  Quizer
//
//  Created by Alan J Hughes on 25/05/2020.
//  Copyright © 2020 Alan Hughes. All rights reserved.
//

import UIKit

class CategoryDataSource: NSObject, UITableViewDataSource {
    let categories = Categories.getCategories()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category
        
        return cell
    }
}
