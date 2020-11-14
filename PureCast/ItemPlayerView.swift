//
//  ItemPlayerView.swift
//  PureCast
//
//  Created by Garrett Votaw on 11/10/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import SwiftUI
import AVKit
import FeedKit

struct ItemPlayerView: View {
    
    var podcast: RSSFeedItem
    @ObservedObject var audioPlayer: AudioPlayer
    
    var body: some View {
        
        VideoPlayer(player: audioPlayer.player)
            .onAppear {
                audioPlayer.playPause()
            }
            .onDisappear {
                audioPlayer.playPause()
            }
    }
}

//struct ItemPlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemPlayerView(isPlaying: false, podcastTitle: "Worship God | Desiring God")
//    }
//}
