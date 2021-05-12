//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by Bryson Jones on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var postCommentCountLabel: UILabel!
    
    //MARK: - Properties
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Actions
    
    //MARK: - Helper funcs
    func updateViews() {
        guard let post = post else {return}
        postCaptionLabel.text = post.caption
        postCommentCountLabel.text = "Comments: \(post.comments.count)"
        postImageView.image = post.photo
    }
}//End of class
