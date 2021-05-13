//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Bryson Jones on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
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
        selectImageButton.setTitle("Select Image", for: .normal)
        photoToSelectImageView.image = nil
        captionTextField.text = nil
    }
    
    //MARK: - Properties
    
    //MARK: - Actions
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        photoToSelectImageView.image = UIImage(named: "spaceEmptyState")
        selectImageButton.setTitle(nil, for: .normal)
    }
    
    @IBAction func addPostButtonTapped(_ sender: UIButton) {
        guard let caption = captionTextField.text, !caption.isEmpty,
              let photo = photoToSelectImageView.image else {return}
        
        PostController.shared.createPostWith(image: photo, caption: caption) { result in
            //BJONES
        }
        self.tabBarController?.selectedIndex = 0
        
    }
    @IBAction func cancelBarButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    //MARK: - Functions
    func presentImagePickerActionSheet() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        UIAlertController.Style.actionSheet
        
    }
    
    
}//End of class
