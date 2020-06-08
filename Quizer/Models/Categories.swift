//
//  Categories.swift
//  Quizer
//
//  Created by Alan J Hughes on 25/05/2020.
//  Copyright © 2020 Alan Hughes. All rights reserved.
//

import Foundation


struct Categories {
    private static let categories = ["General Knowledge", "Entertainment: Books", "Entertainment: Film", "Entertainment: Music", "Entertainment: Musical &  Theaters","Entertainment: Television", "Entertainment: Video Games", "Entertainment: Board Games", "Science & Nature", "Science: Computers", "Science: Mathematics", "Mythology", "Sports", "Geography", "History", "Politics", "Art", "Celebrities", "Animals", "Vehicles", "Entertainment: Comics", "Science: Gadgets", "Entertainment: Japanese & Manga", "Entertainment: Cartoon & Animations"
    ]
    
    public static func getCategories() -> [String] {
        return categories
    }
}

