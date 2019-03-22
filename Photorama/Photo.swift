//
//  Photo.swift
//  Photorama
//
//  Created by Hemant Phutela on 14/03/2019.
//  Copyright © 2019 Hemant Phutela. All rights reserved.
//

import Foundation
class Photo {
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    
    init(title: String, photoID: String, remoteURL: URL, dateTaken: Date) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
    
//    static func == (lhs: Photo, rhs: Photo) -> Bool{
//        return lhs.photoID == rhs.photoID
//    }
}

extension Photo: Equatable{
    static func == (lhs: Photo, rhs: Photo) -> Bool{
        return lhs.photoID == rhs.photoID
    }
}
