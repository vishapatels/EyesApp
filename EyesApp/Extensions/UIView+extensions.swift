//
//  UIView+extensions.swift
//  EyesApp
//
//  Created by smitesh patel on 2019-07-23.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /// Adds a view to the end of the receiver’s list of subviews with anchoring by given edgeInset.
    ///
    /// - Parameters:
    ///   - view: The view to be added.
    ///   - edgeInset: The inset distances for views.
    func addConstraintSubview(_ view: UIView, edgeInset: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        view.topAnchor.constraint(equalTo: topAnchor, constant: edgeInset.top).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: edgeInset.bottom).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInset.left).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: edgeInset.right).isActive = true
    }
}
