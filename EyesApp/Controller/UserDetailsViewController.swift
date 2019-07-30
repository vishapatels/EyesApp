//
//  UserDetailsViewController.swift
//  EyesApp
//
//  Created by smitesh patel on 2019-07-29.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit
import Koloda
import Hero

enum HeroIdentifier: String {
    
    case detailHeroImage
}
class CustomKolodaView: KolodaView {}

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var myKolodaView: CustomKolodaView!

    var id: Int64 = 0
    var urlString: String?
    
    @IBOutlet weak var overlayView: UIView!
    private let model = UserDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myKolodaView.dataSource = self
        myKolodaView.delegate = self
        heroImageView.hero.id = HeroIdentifier.detailHeroImage.rawValue
        overlayView.alpha = 0.5
        if let urlString = urlString, let url = URL(string: urlString) {
            heroImageView.kf.setImage(with: url)
        }
        //overlayView.backgroundColor = .overalayColor
        self.modalTransitionStyle =  UIModalTransitionStyle.flipHorizontal
        
        model.getUserDetail(id: id,ignoreCache: true, completion: { [weak self] (result) in
            self?.removeLoadingView()
            switch result {
            case .success:
                self?.myKolodaView.reloadData()
            case .failure(let err):
                print(err)
            }
        })
    }
    
    @IBAction func leftButtonTapped() {
        myKolodaView?.swipe(.left)
    }
    
    @IBAction func rightButtonTapped() {
        myKolodaView?.swipe(.right)
    }
    
    @IBAction func undoButtonTapped() {
        myKolodaView?.revertAction()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: KolodaViewDelegate
extension UserDetailsViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        myKolodaView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.openURL(URL(string: "www.google.ca")!)
    }
}

// MARK: KolodaViewDataSource

extension UserDetailsViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return model.numberOfRows
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let content = model.usersDetailAtIndex(atIndex: index)?.data ?? ""
        if let type: MediaType = model.usersDetailAtIndex(atIndex: index)?.type {
            return UserDetailsView.create(type: type,content: content)
        } else {
            return UserDetailsView.create(type: .text, content: "No Data Available")
        }
    }
}
