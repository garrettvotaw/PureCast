//
//  PodcastListView.swift
//  PureCast
//
//  Created by Garrett Votaw on 10/28/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import SwiftUI
import FeedKit
import AVKit

struct PodcastListView: View {
    
    @ObservedObject var audioPlayer: AudioPlayer
    @StateObject var podcastDownloader: PodcastDownloader
    let podcastTitle: String
    
    var body: some View {
        ScrollView {
            ForEach(podcastDownloader.podcasts, id: \.id) { item in
                if item.isVideo {
                    NavigationLink(
                        destination: VideoPlayer(player: audioPlayer.player)
                            .onAppear {
                                audioPlayer.url = item.audioURL
                            },
                        label: {
                            VideoPodcastRow(item: item, audioPlayer: audioPlayer)
                        })
                } else {
                    PodcastRow(item: item, audioPlayer: audioPlayer)
                }
            }
            .navigationBarTitle(Text("\(podcastTitle)"))
        }
    }
}

