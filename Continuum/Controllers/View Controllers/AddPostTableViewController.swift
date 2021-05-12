//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Bryson Jones on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var photoToSelectImageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var captionTextField: UITextField!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        selectImageButton.titleLabel?.text = "Select Image"
        photoToSelectImageView.image = nil
        captionTextField.text = nil
    }
    
    //MARK: - Properties
    var post: Post?
    
    //MARK: - Actions
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        photoToSelectImageView.image = UIImage(named: "spaceEmptyState")
        selectImageButton.isOpaque.toggle()
    }
    
    @IBAction func addPostButtonTapped(_ sender: UIButton) {
        guard let caption = captionTextField.text, !caption.isEmpty,
              let photo = photoToSelectImageView.image, photo.size.width != 0 else {return}
        
        if let post = post {
            post.photo = photo
            post.caption = caption
            PostController.shared.createPostWith(image: photo, caption: caption) { result in
                //BJONES
            }
        } else {
            return
        }
        self.tabBarController?.selectedIndex = 0
    }
    @IBAction func cancelBarButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
                
        return cell
    }
}//End of class
