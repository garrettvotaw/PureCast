//
//  Podcast.swift
//  PureCast
//
//  Created by Garrett Votaw on 11/11/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import Foundation

class PodcastFeed: ObservableObject, Identifiable {
    let title: String
    let url: URL
    let id = UUID()
    
    init(title: String, url: URL) {
        self.title = title
        self.url = url
    }
}
