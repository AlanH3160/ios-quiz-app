//
//  Question.swift
//  Quizer
//
//  Created by Alan J Hughes on 25/05/2020.
//  Copyright © 2020 Alan Hughes. All rights reserved.
//

import Foundation

struct Quiz: Decodable {
    let results: [Question]
}

struct Question: Decodable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
