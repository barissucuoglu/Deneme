//
//  UIView+Ext.swift
//  TableView
//
//  Created by Barış Sucuoğlu on 23.02.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
