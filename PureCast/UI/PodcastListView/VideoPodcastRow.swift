//
//  VideoPodcastRow.swift
//  PureCast
//
//  Created by Garrett Votaw on 11/30/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import SwiftUI

struct VideoPodcastRow: View {
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
            .padding(.trailing)
            .padding(.vertical)
            Divider()
                .padding(.leading, 15)
        }
    }
}
