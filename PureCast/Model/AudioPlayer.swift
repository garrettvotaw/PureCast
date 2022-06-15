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
import MediaPlayer
import SwiftUI

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
            if isPlaying {
                if newValue == _url {
                    return
                } else {
                    player.pause()
                    player.replaceCurrentItem(with: nil)
                    _url = newValue
                    player.replaceCurrentItem(with: AVPlayerItem(url: newValue!))
                    addPeriodicTimeObserver()
                    setupNowPlaying()
                    player.play()
                }
            } else {
                _url = newValue
                player.replaceCurrentItem(with: AVPlayerItem(url: newValue!))
                setupNowPlaying()
                addPeriodicTimeObserver()
                player.play()
            }
            
        }
    }
    @Published var showPlayer: Bool = true
    
    
    @Published var currentItem: String = " "
    @Published var isPlaying: Bool = false
    
    
    
    func playPause() {
        isPlaying ? player.pause() : player.play(); addPeriodicTimeObserver()
        setupNowPlaying()
    }

    func seekForward() {
        let current = player.currentTime()
        let newTime = CMTime(seconds: current.seconds + 30, preferredTimescale: 500)
        player.seek(to: newTime)
        setupNowPlaying(currentTime: current.seconds + 30)
    }
    
    func seekFarForward() {
        let current = player.currentTime()
        let newTime = CMTime(seconds: current.seconds + 1800, preferredTimescale: 500)
        player.seek(to: newTime)
        setupNowPlaying(currentTime: current.seconds + 1800)
    }
    
    func seekBack() {
        let current = player.currentTime()
        let newTime = CMTime(seconds: current.seconds - 15, preferredTimescale: 600)
        player.seek(to: newTime)
        setupNowPlaying(currentTime: current.seconds - 15)
    }
    
    func seekFarBack() {
        let current = player.currentTime()
        let newTime = CMTime(seconds: current.seconds - 900, preferredTimescale: 600)
        player.seek(to: newTime)
        setupNowPlaying(currentTime: current.seconds - 900)
    }
    
    
    
    func addPeriodicTimeObserver() {
        // Periodically observe the player's current time, whilst playing
            timeObservation = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 600), queue: nil) { [weak self] time in
                guard let self = self else { return }
                // Publish the new player time
                self.publisher.send(time.seconds)
                if self.player.timeControlStatus == .playing {
                    self.isPlaying = true
                } else {
                    self.isPlaying = false
                }
            }
    }
    
    func setupNowPlaying(currentTime: Double? = nil) {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        let playerItem = player.currentItem
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = "\(currentItem)"

        let image = UIImage(imageLiteralResourceName: "LockScreenAudioImage")
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in return image }
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentTime == nil ? playerItem?.currentTime().seconds : currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = playerItem?.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate

        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func changePlaybackPosition(seekTo location: CMTime) {
        player.seek(to: location)
    }
    
    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            if self.player.rate == 0.0 {
                self.player.play()
                setupNowPlaying()
                return .success
            }
            return .commandFailed
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.player.rate == 1.0 {
                self.player.pause()
                setupNowPlaying()
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.skipForwardCommand.addTarget { [unowned self] event in
            seekForward()
            return .success
        }
        
        commandCenter.skipBackwardCommand.addTarget {[unowned self] event in
            seekBack()
            return .success
        }
        
        commandCenter.changePlaybackPositionCommand.addTarget { [unowned self] (event) in
            print(event.timestamp)
            self.player.pause()
            self.player.seek(to: CMTime(seconds: event.timestamp, preferredTimescale: 600))
            setupNowPlaying(currentTime: event.timestamp)
            self.player.play()
            return .success
        }
        
        commandCenter.nextTrackCommand.isEnabled = false
        commandCenter.previousTrackCommand.isEnabled = false
        
        commandCenter.skipForwardCommand.isEnabled = true
        commandCenter.skipForwardCommand.preferredIntervals = [NSNumber(integerLiteral: 30)]
        
        commandCenter.skipBackwardCommand.isEnabled = true
        commandCenter.skipBackwardCommand.preferredIntervals = [NSNumber(integerLiteral: 15)]
        
        commandCenter.changePlaybackPositionCommand.isEnabled = false
        
        commandCenter.seekForwardCommand.isEnabled = false
        commandCenter.seekBackwardCommand.isEnabled = false
    }
    
    init() {
        setupRemoteTransportControls()
    }
    
}
