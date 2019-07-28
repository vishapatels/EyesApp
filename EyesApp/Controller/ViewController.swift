//
//  ViewController.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Kingfisher
import UIKit

final class ViewController: UIViewController {

    @IBOutlet var collectionviewTopConstraint: NSLayoutConstraint!
    @IBOutlet var collectionView: UICollectionView!

    private let model = UserListViewModel()
    private let animations = [AnimationType.from(direction: .left, offset: 50.0)]
    private let animationsR = [AnimationType.from(direction: .right, offset: 50.0)]
    private lazy var animateView: Void = {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.animateCollectionView()
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Users"
        showLoadingView()

        model.getUserList(ignoreCache: true, completion: { [weak self] result in
            self?.removeLoadingView()
            switch result {
            case .success:
                self?.collectionView.reloadData()
                _ = self?.animateView
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let animationVC = storyboard?.instantiateViewController(withIdentifier: "BackgroundAnimationViewController") as! BackgroundAnimationViewController
        animationVC.id = model.usersAtIndex(atIndex: indexPath.row)?.id ?? 0
        navigationController?.pushViewController(animationVC, animated: true)
    }
}

// Private methods

extension ViewController {

    func animateCollectionView() {
        collectionviewTopConstraint.constant = 0
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { [weak self] _ in
            self?.animateCollectionViewCells()
        }
    }

    func animateCollectionViewCells() {

        collectionView?.performBatchUpdates({
            UIView.animate(views: self.collectionView!.evenCells,
                           animations: animations, completion: {
                               // sender.isEnabled = true
            })
        }, completion: nil)
        collectionView?.performBatchUpdates({
            UIView.animate(views: self.collectionView!.oddCells,
                           animations: animationsR, completion: {
                               // sender.isEnabled = true
            })
        }, completion: nil)
    }
}
