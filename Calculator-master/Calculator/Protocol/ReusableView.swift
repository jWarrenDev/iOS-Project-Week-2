//
//  Reusable.swift
//  Calculator
//

import UIKit
protocol ReusableView: class {}

extension ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: ReusableView { }
extension UICollectionViewCell: ReusableView { }
