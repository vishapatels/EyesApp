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
    
    @IBOutlet weak var stackView: UIStackView!
    private var type: MediaType = .text
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setRound(withRadius: 20)
        
    }
    
    static func create(type: MediaType, content: String) -> UserDetailsView {
        let view = UserDetailsView.loadFromNib(fromBundle: Bundle(for: UserDetailsView.self))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(type: type, content: content)
        return view
    }
    
    @objc func playerItemDidReachEnd() {
        print("videoEnded")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
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
//            var gradientColors: [UIColor] {
//                return [.bubblegumPink, .easterPurple]
//            }
//            stackView.applyGradient(colors: gradientColors, locations: [0.0, 1])
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
        
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = videoPlayerView.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        videoPlayerView.layer.addSublayer(playerLayer!)
        player?.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name(rawValue: "com.player.playended"), object: player?.currentItem!)
    }
}


extension UIColor {
    @nonobjc class var bubblegumPink: UIColor {
        return UIColor(red: 1.0, green: 133.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var easterPurple: UIColor {
        return UIColor(red: 171.0 / 255.0, green: 108.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
}
