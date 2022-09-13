//
//  TimerLabel.swift
//  SquaresAndRectanglesCodingChallenge
//
//  Created by Steven Hill on 13/09/2022.
//

import UIKit

class TimerLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, weight: UIFont.Weight, textColor: UIColor, text: String, numberOfLines: Int) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.monospacedSystemFont(ofSize: fontSize, weight: weight)
        self.textColor = textColor
        self.text = text
        self.numberOfLines = numberOfLines
        self.translatesAutoresizingMaskIntoConstraints = false
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss:SSS"
    }
}
