//
//  Request.swift
//  Quizer
//
//  Created by Alan J Hughes on 25/05/2020.
//  Copyright © 2020 Alan Hughes. All rights reserved.
//

import Foundation

class Request {
    
    static func fetchData(url: URL?, completion: @escaping ([Question]) -> Void) {
        guard let url = url else { return }
        var results = [Question]()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            let questions = try? decoder.decode(Quiz.self, from: data).results
            
            if let questions = questions {
                for question in questions {
                    results.append(question)
                }
            }
            
            DispatchQueue.main.async {
                completion(results)
            }
        }
        task.resume()
    }
    
    static func createURL(amount: String, categoryNumber: Int, difficulty: String, type: String) -> URLComponents {
        var components = URLComponents(string: "https://opentdb.com/api.php")!
        
        let numberOfQuestions = URLQueryItem(name: "amount", value: amount)
       
        let category = categoryNumber != 0 ? URLQueryItem(name: "category", value: "\(categoryNumber)") : nil
        
        let difficultyValue = URLQueryItem(name: "difficulty", value: difficulty)
        
        let typeValue = type == "multiple" ? type : "boolean"
        let quizType = URLQueryItem(name: "type", value: typeValue)
        
        let queryItems: [URLQueryItem?] = [numberOfQuestions, category, difficultyValue, quizType]
        
        components.queryItems = queryItems.compactMap { $0 }
        
        return components
    }
    
}
