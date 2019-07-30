//
//  Animation.swift
//  Pods-ViewAnimator_Example
//
//  Created by Visha Shanghvi on 2019-07-29.
//

import UIKit

/// Animation protocol defines the initial transform for a view for it to
/// animate to its identity position.
public protocol Animation {

    /// Defines the starting point for the animations. 
    var initialTransform: CGAffineTransform { get }
}
