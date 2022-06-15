//
//  Podcast.swift
//  PureCast
//
//  Created by Garrett Votaw on 11/14/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import Foundation
import FeedKit
import SwiftSoup

struct Podcast {
    let title: String
    let description: String?
    let pubDate: String?
    let audioURL: URL
    let id = UUID()
    let isVideo: Bool
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        
        
        let date = feedItem.pubDate!
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        self.pubDate = formatter.string(from: date)
        
        if let type = feedItem.enclosure?.attributes?.type, let author = feedItem.iTunes?.iTunesAuthor {
            if type.contains("video") && author == "John Piper" {
                self.isVideo = true
            } else {
                self.isVideo = false
            }
        } else {
            self.isVideo = false
        }
        
        
        

        if let description = feedItem.description, description != "" {
            let doc = try! SwiftSoup.parse(description)
            self.description = try! doc.text()
        } else {
            self.description = nil
        }
        
        
        guard let url = feedItem.enclosure?.attributes?.url else {
            self.audioURL = URL(string: "https://desiringgod.org")!
            return
        }
        self.audioURL = URL(string: url)!
        
        
    }
}
