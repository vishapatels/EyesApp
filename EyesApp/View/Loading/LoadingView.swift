//
//  LoadingView.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//
import UIKit

final class LoadingView: UIView {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()

        activityIndicatorView.tintColor = UIColor.black
    }

    var isBlocking: Bool = false {
        didSet {
            if isBlocking {
                backgroundColor = UIColor(white: 0, alpha: 0.4)
                activityIndicatorView.style = .white
            }
        }
    }
}
