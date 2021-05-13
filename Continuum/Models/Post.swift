//
//  Post.swift
//  Continuum
//
//  Created by Bryson Jones on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

//MARK: - Constants
struct PostConstants {
    
    static let typeKey = "Post"
    static let captionKey = "caption"
    static let timestampKey = "timestamp"
    static let commentsKey = "comments"
    static let photoKey = "photo"
    static let commentCountKey = "commentCount"
}

//MARK: - Model
class Post {
    
    var photoData: Data?
    var timestamp: Date
    var caption: String
    var comments: [Comment]
    var commentCount: Int
    let recordID: CKRecord.ID
    
    var photo: UIImage? {
        get {
            guard let photoData = photoData else { return nil }
            return UIImage(data: photoData)
        }
        set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    var imageAsset: CKAsset? {
        get {
            let tempDirectory = NSTemporaryDirectory()
            let tempDirectoryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirectoryURL.appendingPathComponent(recordID.recordName).appendingPathExtension("jpg")
            
            do {
                try photoData?.write(to: fileURL)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    
    init(photo: UIImage?, caption: String, timestamp: Date = Date(), comments: [Comment] = [], recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), commentCount: Int = 0) {
        
        self.caption = caption
        self.comments = comments
        self.timestamp = timestamp
        self.recordID = recordID
        self.commentCount = commentCount
        self.photo = photo
    }
}//End of class

//MARK: - Extensions
extension Post: SearchableRecord {
    
    func matches(searchTerm: String) -> Bool {
        
        if caption.lowercased().contains(searchTerm.lowercased()) {
            return true
        } else {
            return false
        }
    }
}//End of extension

extension CKRecord {
    
    convenience init(post: Post) {
        
        self.init(recordType: PostConstants.typeKey, recordID: post.recordID)
        
        self.setValuesForKeys([
            PostConstants.captionKey : post.caption,
            PostConstants.timestampKey : post.timestamp,
            PostConstants.commentCountKey : post.commentCount
        ])
        if let postPhoto = post.imageAsset {
            self.setValue(postPhoto, forKey: PostConstants.photoKey)
        }
    }
}//End of extension

extension Post {
    
    convenience init?(ckRecord: CKRecord) {
        guard let caption = ckRecord[PostConstants.captionKey] as? String,
              let timestamp = ckRecord[PostConstants.timestampKey] as? Date,
              let commentCount = ckRecord[PostConstants.commentCountKey] as? Int else {return nil}
        
        var postPhoto: UIImage?
        
        if let photoAsset = ckRecord[PostConstants.photoKey] as? CKAsset {
            do {
                //BJONES
                //The line below needs to ssy "guard let url = photoAsset.fileURL else {return}" but Xcode hates me
                let url = photoAsset.fileURL
                let data = try Data(contentsOf: url)
                postPhoto = UIImage(data: data)
            } catch {
                print("Could not convert asset to data.")
            }
        }
        self.init(photo: postPhoto, caption: caption, timestamp: timestamp, comments: [], recordID: ckRecord.recordID, commentCount: commentCount)
    }
}//End of extension
