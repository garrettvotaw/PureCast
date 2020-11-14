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
                PodcastRow(item: item, audioPlayer: audioPlayer)
            }
            .navigationBarTitle(Text("\(podcastTitle)"))
            
        }
        
    }
}


// MARK: ROW VIEW---------------------------------------------------------------------------------------------------------------------------


struct PodcastRow: View {
    
    var item: Podcast
    @ObservedObject var audioPlayer: AudioPlayer
    
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    
                    Text(item.title)
                    .padding(.bottom, 10)
                    .font(.headline)
                    Spacer()
                }
                
                HStack {
                        if let description = item.description {
                            Text("\(description)")
                        } else {
                            EmptyView()
                        }
                    Spacer()
                }
            }
            .padding(.leading, 30)
            .padding(.vertical)
            Divider()
                .padding(.leading, 15)
        }
        .onTapGesture {
            if audioPlayer.isPlaying {
                if audioPlayer.url == item.audioURL {
                    return
                } else {
                    audioPlayer.playPause()
                    audioPlayer.url = item.audioURL
                    audioPlayer.currentItem = item.title
                    audioPlayer.playPause()
                }
            } else {
                audioPlayer.url = item.audioURL
                audioPlayer.currentItem = item.title
                audioPlayer.playPause()
            }
        }
        
    }
}


//struct PodcastListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PodcastListView()
//    }
//}




extension RSSFeedItem: Identifiable {
    public var id: UUID {
        return UUID()
    }
}
