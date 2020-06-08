//
//  CategotyTableViewController.swift
//  Quizer
//
//  Created by Alan J Hughes on 25/05/2020.
//  Copyright © 2020 Alan Hughes. All rights reserved.
//

import UIKit

class CategotyTableViewController: UITableViewController {
    // MARK: Properties
    let dataSource = CategoryDataSource()
    var updateTitle: ((String, Int) -> Void)?
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

// MARK: Delegate Methods
extension CategotyTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = dataSource.categories[indexPath.row]
        updateTitle?(category, indexPath.row)
        dismiss(animated: true, completion: nil)
    }
}
