//
//  ViewController.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit
import Kingfisher

final class ViewController: UIViewController {

    
   
    @IBOutlet weak var collectionView: UICollectionView!
    let model = UserListViewModel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getUserList(completion: { [weak self] (result) in
            switch result {
            case .success:
                self?.collectionView.reloadData()
            case .failure(let err):
                print(err)
            }
        })
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserList", for: indexPath) as! UsersListCell
         cell.userNameLbl.text = model.usersAtIndex(atIndex: indexPath.row)?.name
        if let url = URL(string: model.usersAtIndex(atIndex: indexPath.row)?.image ?? "NA") {
            cell.imageLbl.kf.setImage(with: url)
        }
        return cell
    }
}

