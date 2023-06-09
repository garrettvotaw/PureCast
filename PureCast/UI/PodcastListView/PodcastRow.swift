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
                                    Text(description)
                                        .lineLimit(15)
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
        }
    }
}
