//
//  PostController.swift
//  Continuum
//
//  Created by Bryson Jones on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit
import CloudKit

class PostController {
    
    //MARK: - Properties
    static let shared = PostController()
    var posts: [Post] = []
    let publicDB = CKContainer.default().publicCloudDatabase
    private init() {
        
    }
    
    //MARK: - CRUD
    func addComment(text: String, post: Post, completion: @escaping (Result<Comment, PostError>) -> Void) {
        
        let postReference = CKRecord.Reference(recordID: post.recordID, action: .none)
        let newComment = Comment(text: text, postReference: postReference)
        post.comments.append(newComment)
        let record = CKRecord(comment: newComment)
    }
    
    func createPostWith(image: UIImage, caption: String, completion: @escaping (Result<Post?, PostError>) -> Void) {
        let newPost = Post(photo: image, caption: caption)
        posts.append(newPost)
        
    }
    
    
}//End of class
