//
//  UIViewController+Extensions.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-23.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit
// MARK: - Loading View
extension UIViewController {
    
    var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func showLoadingView(isBlocking: Bool = false) {
        let loadingView: LoadingView = LoadingView.loadFromNib()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isBlocking = isBlocking
        
        if isBlocking {
            appDelegate?.window?.addConstraintSubview(loadingView)
        } else {
            view.addConstraintSubview(loadingView)
            view.bringSubviewToFront(loadingView)
        }
    }
    
    func removeLoadingView() {
        view.subviews.first(where: { $0 is LoadingView })?.removeFromSuperview()
        appDelegate?.window?.subviews.first(where: { $0 is LoadingView })?.removeFromSuperview()
    }
}
