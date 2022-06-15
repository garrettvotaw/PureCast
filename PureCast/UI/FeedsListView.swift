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
//        PodcastFeed(title: "9to5 Mac", url: URL(string: "https://9to5mac.com/rss")!),
//        PodcastFeed(title: "Accidental Tech Podcast", url: URL(string: "https://atp.fm/rss")!),
//        PodcastFeed(title: "Under the Radar", url: URL(string: "https://www.relay.fm/radar/feed")!),
        PodcastFeed(title: "UpperRoom Prayer", url: URL(string: "https://anchor.fm/s/4d4b1d90/podcast/rss")!),
        PodcastFeed(title: "Invasion of Light", url: URL(string: "https://podpoint.com/feed/6469")!)
//        PodcastFeed(title: "UpperRoom Sermon", url: URL(string: "https://www.urdallas.com/podcast?format=RSS")!),
//        PodcastFeed(title: "Brave Heart Ministries", url: URL(string: "https://feeds.buzzsprout.com/131567.rss")!),
//        PodcastFeed(title: "Jesus Image", url: URL(string: "https://feeds.buzzsprout.com/121969.rss")!),
//        PodcastFeed(title: "Eric Gilmour", url: URL(string: "https://feed.podbean.com/ericgilmour/feed.xml")!),
//        PodcastFeed(title: "The Bible Project", url: URL(string: "https://feeds.simplecast.com/3NVmUWZO")!),
//        PodcastFeed(title: "Exploring My Strange Bible", url: URL(string: "https://feeds.simplecast.com/zovPCGLI")!),
//        PodcastFeed(title: "Look at the Book", url: URL(string: "https://feed.desiringgod.org/look-at-the-book.rss")!),
//        PodcastFeed(title: "John Piper Sermons", url: URL(string: "https://feed.desiringgod.org/messages.rss")!),
//        PodcastFeed(title: "Sermon of the Day", url: URL(string: "https://feed.desiringgod.org/sermon-of-the-day.rss")!),
//        PodcastFeed(title: "Devotionals", url: URL(string: "https://feed.desiringgod.org/solid-joys-audio.rss")!),
//        PodcastFeed(title: "Dave Ramsey Show", url: URL(string: "https://daveramsey.libsyn.com/rss")!)
    ]
    
    var body: some View {
        NavigationView {
            List(podcasts) { item in
                NavigationLink(
                    destination: PodcastListView(audioPlayer: audioPlayer, podcastDownloader: PodcastDownloader(feedURL: item.url), podcastTitle: item.title),
                    label: {
                        PodcastListItem(item: item)
                    })
                    .navigationBarTitle(Text("Podcasts"))
            }
        }
        .accentColor(Color("BlackWhite"))
    }
}



struct PodcastListItem: View {
    
    var item: PodcastFeed
    
    var body: some View {
        VStack {
            Text("\(item.title)").padding()
        }
        
    }
    
}
