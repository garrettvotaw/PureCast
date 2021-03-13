//
//  Podcast.swift
//  PureCast
//
//  Created by Garrett Votaw on 11/11/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import Foundation
import UIKit

class PodcastFeed: ObservableObject, Identifiable {
    let title: String
    let url: URL
    let id = UUID()
    let image: UIImage?
    let desc: String?
    
    init(title: String, url: URL, image: UIImage? = nil, desc: String? = nil) {
        self.title = title
        self.url = url
        self.image = image
        self.desc = desc
    }
}
