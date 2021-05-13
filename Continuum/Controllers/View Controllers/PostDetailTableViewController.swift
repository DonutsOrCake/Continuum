//
//  PostDetailTableViewController.swift
//  Continuum
//
//  Created by Bryson Jones on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var postCommentButton: UIButton!
    @IBOutlet weak var postShareButton: UIButton!
    @IBOutlet weak var postFollowButton: UIButton!
    
    //MARK: - Properties
    var post: Post? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let post = post else {return}
        //BJONES
    }
    
    //MARK: - Actions
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        guard let post = post else {return}
        let commentAlert = UIAlertController(title: "Comment", message: "Add your thoughts", preferredStyle: UIAlertController.Style.alert)
        commentAlert.addTextField { textField in
            textField.placeholder = "Enter comment here..."
        }
        commentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            guard let text = commentAlert.textFields?.first?.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {return}
            PostController.shared.addComment(text: text, post: post) { result in
                //BJONES
            }
            self.tableView.reloadData()
        }))
        commentAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(commentAlert, animated: true, completion: nil)
    }
    
    //MARK: - Functions
    func updateViews() {
        guard let post = post else {return}
        photoImageView.image = post.photo
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let post = post else {return UITableViewCell()}
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        let comment = post.comments[indexPath.row]
        cell.textLabel?.text = comment.text
        cell.detailTextLabel?.text = "\(comment.timestamp)"

        return cell
    }
}//End of class
