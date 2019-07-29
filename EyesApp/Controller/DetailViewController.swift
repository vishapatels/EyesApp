//
//  DetailViewController.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit
//import Koloda

enum CellIdentifier: String {
    
    case detailCell = "DetailCell"
}

class DetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var id: Int64 = 0
    private let model = UserDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "User Detail"
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        showLoadingView()
        
        collectionView.register(DetailViewCell.nib, forCellWithReuseIdentifier: CellIdentifier.detailCell.rawValue)
        
        model.getUserDetail(id: id,ignoreCache: true, completion: { [weak self] (result) in
            self?.removeLoadingView()
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
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.detailCell.rawValue, for: indexPath) as! DetailViewCell
        if(model.usersDetailAtIndex(atIndex: indexPath.row)?.type.rawValue == "video" ) {
            if let url = URL(string: (model.usersDetailAtIndex(atIndex: indexPath.row)?.data ?? "")) {
                cell.playVideo(url: url)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.detailCell.rawValue, for: indexPath) as! DetailViewCell
        if(model.usersDetailAtIndex(atIndex: indexPath.row)?.type.rawValue == "video" ) {
            cell.label.isHidden = true
            cell.label.alpha = 0.0
            cell.image.isHidden = true
            cell.image.alpha = 0.0
            if let url = URL(string: (model.usersDetailAtIndex(atIndex: indexPath.row)?.data ?? "")) {
                cell.playVideo(url: url)
            }
        }
       else  if(model.usersDetailAtIndex(atIndex: indexPath.row)?.type.rawValue == "text" ) {
            cell.label.text = model.usersDetailAtIndex(atIndex: indexPath.row)?.data
            cell.videoPlayerView.isHidden = true
            cell.videoPlayerView.alpha = 0.0
            cell.image.isHidden = true
            cell.image.alpha = 0.0
        }
       else if(model.usersDetailAtIndex(atIndex: indexPath.row)?.type.rawValue == "image" ) {
                if let url = URL(string: model.usersDetailAtIndex(atIndex: indexPath.row)?.data ?? "NA") {
                    cell.image.kf.setImage(with: url)
                    cell.label.isHidden = true
                    cell.label.alpha = 0.0
                    cell.videoPlayerView.isHidden = true
                    cell.videoPlayerView.alpha = 0.0
                }

        }
        return cell
    }
    
    
}

