//
//  AudioPlayer.swift
//  PureCast
//
//  Created by Garrett Votaw on 11/11/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import Foundation
import AVKit
import Combine

class AudioPlayer: ObservableObject {
    let player = AVPlayer()
    let publisher = PassthroughSubject<TimeInterval, Never>()
    private var timeObservation: Any?
    var progress: Double = 0.0
    private var _url: URL?
    var url: URL? {
        get {
            return _url
        }
        set {
            _url = newValue
            player.replaceCurrentItem(with: AVPlayerItem(url: newValue!))
        }
    }
    
    @Published var currentItem: String = " "
    @Published var isPlaying: Bool = false
    
    
    
    func playPause() {
        isPlaying ? player.pause() : player.play(); addPeriodicTimeObserver()
        isPlaying.toggle()
    }

    func seekForward() {
        let current = player.currentTime()
        let newTime = CMTime(seconds: current.seconds + 30, preferredTimescale: 500)
        player.seek(to: newTime)
    }
    
    func seekBack() {
        let current = player.currentTime()
        let newTime = CMTime(seconds: current.seconds - 15, preferredTimescale: 600)
        player.seek(to: newTime)
    }
    
    
    func addPeriodicTimeObserver() {
        // Periodically observe the player's current time, whilst playing
            timeObservation = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 600), queue: nil) { [weak self] time in
              guard let self = self else { return }
              // Publish the new player time
              self.publisher.send(time.seconds)
            }
    }
    
}
