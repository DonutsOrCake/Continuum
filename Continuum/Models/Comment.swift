//
//  Comment.swift
//  Continuum
//
//  Created by Bryson Jones on 5/12/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import Foundation
import CloudKit

//MARK: - Strings
struct CommentConstants {
    
    static let recordType = "Comment"
    static let textKey = "text"
    static let timestampKey = "timestamp"
    static let postReferenceKey = "post"
}

//MARK: - Model
class Comment {
    
    var text: String
    var timestamp: Date
    let recordID: CKRecord.ID
    var postReference: CKRecord.Reference?
    
    init(text: String, timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), postReference: CKRecord.Reference) {
        self.text = text
        self.timestamp = timestamp
        self.recordID = recordID
        self.postReference = postReference
    }
}//End class

extension Comment {
    
    convenience init?(ckRecord: CKRecord) {
        guard let text = ckRecord[CommentConstants.textKey] as? String,
              let timestamp = ckRecord[CommentConstants.timestampKey] as? Date,
              let postReference = ckRecord[CommentConstants.postReferenceKey] as? CKRecord.Reference else {return nil}
        
        self.init(text: text, timestamp: timestamp, recordID: ckRecord.recordID, postReference: postReference)
    }
}//End extension

extension CKRecord {
    
    convenience init(comment: Comment) {
        
        self.init(recordType: CommentConstants.recordType, recordID: comment.recordID)
        
        self.setValuesForKeys([
            CommentConstants.textKey : comment.text,
            CommentConstants.timestampKey : comment.timestamp
        ])
        
        if let reference = comment.postReference {
            self.setValue(reference, forKey: CommentConstants.postReferenceKey)
        }
    }
}//End extension
