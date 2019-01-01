//
//  CalculatorBtn.swift
//  Calculator
//
// 

import UIKit

class CalcButton: UIButton {
    
    private var color: UIColor!
    var operation: String!
    
    func setupView(){
        self.backgroundColor = color
        let text = NSAttributedString(string: operation,
                                      attributes: [NSAttributedString.Key.font :  UIFont(name: "AvenirNext-Medium", size: 40)!,
                                                   NSAttributedString.Key.foregroundColor : Appearance.bg.color])
        self.setAttributedTitle(text, for: .normal)
        self.layer.cornerRadius = 2
    }
    
    required init(op: String, color: UIColor = Appearance.white.color, tag: Int) {
        super.init(frame: .zero)
        self.color = color
        self.operation = op
        self.tag = tag
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalcButton {
    func zoomIn(duration: TimeInterval = 0.1) {
        self.transform = CGAffineTransform(scaleX: 2.95, y: 2.95)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.transitionCurlUp], animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
