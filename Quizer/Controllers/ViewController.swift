//
//  ViewController.swift
//  Quizer
//
//  Created by Alan Hughes on 24/05/2020.
//  Copyright © 2020 Alan Hughes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
	@IBOutlet var categoryButton: UIButton!
	@IBOutlet var difficultyControl: UISegmentedControl!
	@IBOutlet var quizTypeControl: UISegmentedControl!
    @IBOutlet var questionAmount: UISegmentedControl!
    @IBOutlet var launchButton: LaunchButton!
    @IBOutlet var spinnerView: UIView!
    
    // MARK: Properties
    var selectedAmount: String {
        questionAmount.titleForSegment(at: questionAmount.selectedSegmentIndex) ?? "10"
    }
    
    var selectedDifficuly: String {
        difficultyControl.titleForSegment(at: difficultyControl.selectedSegmentIndex)?.lowercased() ?? ""
    }
    
    var selectedType: String {
        quizTypeControl.titleForSegment(at: quizTypeControl.selectedSegmentIndex)?.lowercased() ?? "multiple"
    }
    
    var selectedCategoryPosition = 0
    
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
		super.viewDidLoad()
        
        categoryButton.layer.cornerRadius = 8
        categoryButton.tintColor = .black
        
        difficultyControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        difficultyControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        quizTypeControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        quizTypeControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        questionAmount.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        questionAmount.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
	}
    
    override func viewWillAppear(_ animated: Bool) {
        launchButton.isHidden = false
        spinnerView.removeFromSuperview()
    }
    
    // MARK: Actions

    @IBAction func launchQuiz(_ sender: LaunchButton) {
        launchButton.isHidden = true
        showActivityView()
        
        let createdUrl = Request.createURL(amount: selectedAmount, categoryNumber: selectedCategoryPosition, difficulty: selectedDifficuly, type: selectedType)
        
        guard let url = createdUrl.url else { return }
        guard let vc = storyboard?.instantiateViewController(identifier: "QuizVC") as? QuizViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        
        Request.fetchData(url: url) { questions in
            vc.questions = questions
            
            if questions.count == 0 {
                self.showAlert()
                return
            }
            self.spinnerView.removeFromSuperview()
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func selectCategoryTapped(_ sender: UIButton) {
        let vc = CategotyTableViewController()
        vc.updateTitle = updateCategoryTitle(title:position:)
        present(vc, animated: true)
    }
    
    // MARK: Methods
    
    func updateCategoryTitle(title: String, position: Int) {
        categoryButton.setTitle(title, for: .normal)
        selectedCategoryPosition = position + 9
    }
    
    func showActivityView() {
        spinnerView.center = CGPoint(x: view.center.x, y: view.center.y + 160)
        view.addSubview(spinnerView)
        for view in spinnerView.subviews {
            if let spinner = view as? UIActivityIndicatorView {
                spinner.startAnimating()
            }
        }
    }
    
    func showAlert() {
        let ac = UIAlertController(title: "We're Sorry", message: "There are no questions for this type of quiz at this time", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        spinnerView.removeFromSuperview()
        launchButton.isHidden = false
        present(ac, animated: true)
    }
}

