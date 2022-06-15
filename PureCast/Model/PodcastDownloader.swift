//
//  PodcastDownloader.swift
//  PureCast
//
//  Created by Garrett Votaw on 11/14/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import Foundation
import FeedKit
import Combine

class PodcastDownloader: ObservableObject {
    @Published var podcasts = [Podcast]()
    var cancelationToken: AnyCancellable?
    
    init(feedURL: URL) {
        getPodcasts(url: feedURL)
    }
}

extension PodcastDownloader {
    
    func getPodcasts(url: URL) {
        let parser = FeedParser(URL: url)
        parser.parseAsync { (result) in
            switch result {
            case .success(let feed):
                switch feed {
                case .atom(let feed):
                    print(feed)
                    break
                case .json(let feed):
                    print(feed)
                    break
                case .rss(let feed):
                    for i in feed.items! {
                        DispatchQueue.main.async {
                            self.podcasts.append(Podcast(feedItem: i))
                        }
                    }
                    break
                }
            case .failure(let parserError):
                print(parserError)
            }
        }
    }
    
}

