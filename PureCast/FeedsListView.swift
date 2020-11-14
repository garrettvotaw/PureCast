//
//  PodcastsView.swift
//  PureCast
//
//  Created by Garrett Votaw on 11/11/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import SwiftUI

struct FeedsListView: View {
    
    @ObservedObject var audioPlayer: AudioPlayer
    
    let podcasts = [
//        Podcast(title: "9to5 Mac", url: URL(string: "https://9to5mac.com/rss")!),
        PodcastFeed(title: "John Piper Sermons", url: URL(string: "https://feed.desiringgod.org/messages.rss")!),
        PodcastFeed(title: "Sermon of the Day", url: URL(string: "https://feed.desiringgod.org/sermon-of-the-day.rss")!),
        PodcastFeed(title: "Devotionals", url: URL(string: "https://feed.desiringgod.org/solid-joys-audio.rss")!),
        PodcastFeed(title: "Look at the Book", url: URL(string: "https://feed.desiringgod.org/look-at-the-book.rss")!),
        PodcastFeed(title: "UpperRoom", url: URL(string: "https://www.urdallas.com/podcast?format=RSS")!),
        PodcastFeed(title: "Under the Radar", url: URL(string: "https://www.relay.fm/radar/feed")!)
    ]
    
    var body: some View {
        NavigationView {
            List(podcasts) { item in
                NavigationLink(
                    destination: PodcastListView(audioPlayer: audioPlayer, podcastDownloader: PodcastDownloader(feedURL: item.url), podcastTitle: item.title),
                    label: {
                        PodcastListItem(item: item)
                    })
                
            }
            .navigationBarTitle(Text("Podcasts"))
        }.accentColor(Color("BlackWhite"))
    }
    
    
}

//struct PodcastsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PodcastsView()
//    }
//}



struct PodcastListItem: View {
    
    var item: PodcastFeed
    
    var body: some View {
        Text("\(item.title)").padding()
    }
    
}
