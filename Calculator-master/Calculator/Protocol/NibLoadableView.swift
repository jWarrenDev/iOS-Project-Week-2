//
//  NibLoadable.swift
//  Calculator
//

import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView {
    
    static var nibName: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: NibLoadableView { }
extension UICollectionViewCell: NibLoadableView { }
