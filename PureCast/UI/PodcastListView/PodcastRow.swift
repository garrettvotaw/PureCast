//
//  PodcastRow.swift
//  PureCast
//
//  Created by Garrett Votaw on 11/30/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import SwiftUI

struct PodcastRow: View {
    
    var item: Podcast
    @ObservedObject var audioPlayer: AudioPlayer
    
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack {
                        HStack {
                            
                            Text(item.title)
                            .padding(.bottom, 10)
                            .font(.headline)
                            Spacer()
                            Text(item.pubDate ?? "")
                                .font(.footnote)
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
                }
            }
            .padding(.leading, 30)
            .padding(.trailing)
            .padding(.vertical)
            Divider()
                .padding(.leading, 15)
        }
        .onTapGesture {
            audioPlayer.currentItem = item.title
            audioPlayer.url = item.audioURL
//            if audioPlayer.isPlaying {
//                if audioPlayer.url == item.audioURL {
//                    return
//                } else {
//                    audioPlayer.playPause()
//
//                    audioPlayer.playPause()
//                }
//            } else {
//                audioPlayer.url = item.audioURL
//                audioPlayer.currentItem = item.title
//                audioPlayer.playPause()
//            }
        }
    }
}

//struct PodcastRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PodcastRow.init(item: , audioPlayer: AudioPlayer())
//    }
//}
