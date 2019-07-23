//
//  DetailViewController.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit
//import Koloda

class DetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var id: Int64 = 0
    let model = UserDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getUserDetail(id: id,ignoreCache: false, completion: { [weak self] (result) in
            switch result {
            case .success:
              self?.collectionView.reloadData()
            case .failure(let err):
                print(err)
            }
        })
    }
}

extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailList", for: indexPath) as! DetailViewCell
        if(model.usersDetailAtIndex(atIndex: indexPath.row)?.type == "text" ) {
            cell.label.text = model.usersDetailAtIndex(atIndex: indexPath.row)?.data
        }
        if(model.usersDetailAtIndex(atIndex: indexPath.row)?.type == "image" ) {
                if let url = URL(string: model.usersDetailAtIndex(atIndex: indexPath.row)?.data ?? "NA") {
                    cell.image.kf.setImage(with: url)
                }
        }
        return cell
    }
    
}

