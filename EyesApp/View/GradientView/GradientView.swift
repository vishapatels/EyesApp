//
//  GradientView.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit

final public class GradientView: UIView {
    
    private var colors: [UIColor]?
    private var locations: [NSNumber]?
    private var edgeInSet: UIEdgeInsets?
    
    public func configure(colors: [UIColor], locations: [NSNumber], edgeInset: UIEdgeInsets = .zero) {
        self.colors = colors
        self.locations = locations
        self.edgeInSet = edgeInset
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard let colors = colors, let locations = locations, let edgeInset = edgeInSet else { return }
        applyGradient(colors: colors, locations: locations, edgeInset: edgeInset)
    }
}
