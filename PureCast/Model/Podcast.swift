//
//  Podcast.swift
//  PureCast
//
//  Created by Garrett Votaw on 11/14/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import Foundation
import FeedKit

struct Podcast {
    let title: String
    let description: String?
    let audioURL: URL
    let id = UUID()
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        
        
        if let description = feedItem.description, description != "" {
            let substring = feedItem.description!.split(separator: "<")
            if substring.count > 0 {
                self.description = "\(substring[0].description)"
            } else {
                self.description = "\(description)"
            }
        } else {
            self.description = nil
        }
        
        
        self.audioURL = URL(string: feedItem.enclosure!.attributes!.url!)!
    }
}
