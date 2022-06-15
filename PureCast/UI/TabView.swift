//
//  ContentView.swift
//  PureCast
//
//  Created by Garrett Votaw on 10/28/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import SwiftUI
import FeedKit
import AVKit

struct ContentView: View {
 
    @State private var audioPlayer: AudioPlayer = AudioPlayer()
    
    var body: some View {
        VStack {
            FeedsListView(audioPlayer: audioPlayer)
            if audioPlayer.showPlayer {
                PlayerView(audioPlayer: audioPlayer, audioProgress: $audioPlayer.progress, isVisible: $audioPlayer.showPlayer)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
