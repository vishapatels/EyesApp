//
//  UIView+extensions.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-23.
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
    
    /// Add a shadow on a view's layer with given parameters
    ///
    /// - Parameters:
    ///   - color: The color of the layer’s shadow. Animatable.
    ///   - opacity: The opacity of the layer’s shadow. Animatable.
    ///   - radius: The blur radius (in points) used to render the layer’s shadow. Animatable.
    ///   - offset: The offset (in points) of the layer’s shadow. Animatable.
    func addShadow(color: UIColor, opacity: Float, radius: CGFloat? = nil, offset: CGSize? = nil) {
        layer.masksToBounds = false
        if let offset = offset {
            layer.shadowOffset = offset
        }
        
        if let radius = radius {
            layer.shadowRadius = radius
        }
        
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    /// Round corners of a view with given radius value
    ///
    /// - Parameter
    ///   - corners: The corners for rectangle to be set with radius.
    ///   - radius: The radius to use when drawing rounded corners for the layer’s background. Animatable.
    func setRound(withRadius radius: CGFloat, atCorners corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    
    /// Adds gradient to the view.
    ///
    /// - Parameters:
    ///   - colors: the gradient colors
    ///   - locations: the gradient stops
    ///   - Returns: Nothing - only applies gradient to the view
    public func applyGradient(colors:[UIColor], locations:[NSNumber], edgeInset: UIEdgeInsets = .zero) -> Void {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: bounds.origin.x + edgeInset.left, y: bounds.origin.y + edgeInset.top, width: bounds.size.width - edgeInset.left + edgeInset.right, height: bounds.size.height - edgeInset.top + edgeInset.bottom)
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
