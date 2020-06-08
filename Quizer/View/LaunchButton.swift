//
//  LaunchButton.swift
//  Quizer
//
//  Created by Alan Hughes on 24/05/2020.
//  Copyright © 2020 Alan Hughes. All rights reserved.
//

import UIKit

class LaunchButton: UIButton {

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupButton()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupButton()
	}
	
	private func setupButton() {
		layer.cornerRadius = frame.size.width/2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
		clipsToBounds = true
        backgroundColor = .systemBlue
	
        let font = UIFont(name: "Noteworthy-Bold", size: 24)!
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        let title = NSAttributedString(string: "START", attributes: attributes)
        setAttributedTitle(title, for: .normal)
	}
}
