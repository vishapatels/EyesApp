//
//  DetailViewCell.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-23.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class DetailViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var videoPlayerView: UIView!    
    func playVideo(url videoURL: URL?) {
   
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoPlayerView.bounds
        videoPlayerView.layer.addSublayer(playerLayer)
        player.play()

        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name(rawValue: "com.player.playended"), object: player.currentItem!)
    }
    @objc func playerItemDidReachEnd() {
        print("videoEnded")
    }
}
