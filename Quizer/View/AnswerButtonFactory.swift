//
//  AnswerButtons.swift
//  Quizer
//
//  Created by Alan J Hughes on 25/05/2020.
//  Copyright © 2020 Alan Hughes. All rights reserved.
//

import UIKit

class AnswerButtonFactory {
    
    static func createButtons(for question: Question, amount: Int) -> [UIButton] {
        var buttons = [UIButton]()
        let incorrectAnswers = question.incorrectAnswers
        
        let correctButton = UIButton()
        correctButton.setTitle(question.correctAnswer.removingHTMLEntities, for: .normal)
        correctButton.setTitleColor(.black, for: .normal)
        correctButton.backgroundColor = .white
        correctButton.layer.cornerRadius = 8
        correctButton.layer.borderColor = UIColor.black.cgColor
        correctButton.layer.borderWidth = 3
        buttons.append(correctButton)
        
        for i in 0..<incorrectAnswers.count {
            let button = UIButton()
            button.setTitle(incorrectAnswers[i].removingHTMLEntities, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 8
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 3
            buttons.append(button)
        }
        
        return buttons.shuffled()
    }

}

