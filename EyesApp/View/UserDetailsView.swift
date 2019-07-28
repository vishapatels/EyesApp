//
//  SwipeView.swift
//  EyesApp
//
//  Created by smitesh patel on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

import UIKit
import AVFoundation
import AVKit



final class UserDetailsView: UIView {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var videoPlayerView: UIView!
    
    private var type: MediaType = .text

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public static func create(type: MediaType, content: String) -> UserDetailsView {
        let view = UserDetailsView.loadFromNib(fromBundle: Bundle(for: UserDetailsView.self))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(type: type, content: content)
        return view
    }
    
    @objc func playerItemDidReachEnd() {
        print("videoEnded")
    }
}


// MARK: - Private Methods
extension UserDetailsView {
    
    private func configure(type: MediaType, content: String) {
        switch type {
        case .text:
            [videoPlayerView, image].forEach {
                $0?.isHidden = true
                $0?.alpha = 0.0
            }
            label.text = content
        case .image:
            [label, videoPlayerView].forEach {
                $0?.isHidden = true
                $0?.alpha = 0.0
            }
            if let url = URL(string: content) {
                image.kf.setImage(with: url)
            }
            
        case .video:
            [label, image].forEach {
                $0?.isHidden = true
                $0?.alpha = 0.0
            }
            if let url = URL(string: content) {
                playVideo(url: url)
            }
        }
    }
    
    private func playVideo(url videoURL: URL?) {
        
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoPlayerView.bounds
        videoPlayerView.layer.addSublayer(playerLayer)
        player.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name(rawValue: "com.player.playended"), object: player.currentItem!)
    }
}
