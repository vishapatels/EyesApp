//
//  DetailViewController.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //added
    var id: Int64 = 0
    let model = UserDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getUserDetail(id: String(id),ignoreCache: false, completion: { [weak self] (result) in
            switch result {
            case .success:
               print("success")
            case .failure(let err):
                print(err)
            }
        })
    }
}
extension DetailViewController {
    
}
