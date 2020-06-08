//
//  QuizViewController.swift
//  Quizer
//
//  Created by Alan J Hughes on 25/05/2020.
//  Copyright © 2020 Alan Hughes. All rights reserved.
//

import UIKit
import HTMLString

class QuizViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet var cateoryLabel: UILabel!
    @IBOutlet var difficultyLabel: UILabel!
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var questionView: UIView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionStack: UIStackView!
    
    // MARK: Properties
    var questions: [Question]!
    var currentQuestion = 0
    var score = 0
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initialLayout()
        setUpLabels()
        setUpButtons()
    }
    
    // MARK: Actions
    @IBAction func quitQuiz(_ sender: UIBarButtonItem) {
        quitGameAlert()
    }
    
    
    // MARK: Methods
    func setUpLabels() {
        cateoryLabel.text = questions[currentQuestion].category
        difficultyLabel.text = questions[currentQuestion].difficulty.capitalized
        progressLabel.text = "\(currentQuestion + 1)/\(questions.count)"
        questionLabel.text = questions[currentQuestion].question.removingHTMLEntities
    }
    
    func initialLayout() {
        questionView.layer.cornerRadius = 10
        questionView.layer.borderColor = UIColor.black.cgColor
        questionView.layer.borderWidth = 5
    }
    
    func setUpButtons() {
        for button in questionStack.arrangedSubviews {
            questionStack.removeArrangedSubview(button)
        }
        
        let quizType = questions[currentQuestion].type == "multiple" ? 4 : 2
        
        let buttons = AnswerButtonFactory.createButtons(for: questions[currentQuestion], amount: quizType)
        
        for button in buttons {
            button.addTarget(self, action: #selector(checkAnswer(_:)), for: .touchUpInside)
            questionStack.addArrangedSubview(button)
        }
   
    }
    
    @objc func checkAnswer(_ sender: UIButton) {
        if sender.titleLabel?.text == questions[currentQuestion].correctAnswer {
            score += 1
            
            UIView.animate(withDuration: 0.8, animations: {
                sender.backgroundColor = UIColor(red: 14/255, green: 179/255, blue: 75/255, alpha: 1)
                sender.setTitleColor(.white, for: .normal)
    
            }, completion: { _ in
                sender.backgroundColor = .white
                sender.setTitleColor(.black, for: .normal)
                if self.checkGameOver() {
                    self.gameOver()
                } else {
                    self.setUpLabels()
                    self.setUpButtons()
                }
            })
        } else {
            UIView.animate(withDuration: 0.8, animations: {
                sender.backgroundColor = .red
                sender.setTitleColor(.white, for: .normal)
            }, completion: { _ in
                sender.backgroundColor = .white
                sender.setTitleColor(.black, for: .normal)
                if self.checkGameOver() {
                    self.gameOver()
                } else {
                    self.setUpLabels()
                    self.setUpButtons()
                }
            })
        }
        currentQuestion += 1
    }
    
    func quitGameAlert() {
        let ac = UIAlertController(title: "Quit Quiz", message: "Are you sure you want to quit", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        present(ac, animated: true)
    }
    
    func checkGameOver() -> Bool {
        return currentQuestion == questions?.count
    }
    
    func gameOver() {
        let ac = UIAlertController(title: "Results", message: "You Socred: \(score)/\(questions.count)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] action in
            self?.dismiss(animated: true, completion: nil)
        })
        present(ac, animated: true)
    }
}
