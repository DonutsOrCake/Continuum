//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Bryson Jones on 5/11/21.
//

import UIKit

class AddPostTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var captionTextField: UITextField!
    
    
    //MARK: - Lifecycle
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captionTextField.text = nil
    }
    
    //MARK: - Properties
    var selectedImage: UIImage?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelectorVC" {
            let photoSelector = segue.destination as? PhotoSelectorViewController
            photoSelector?.delegate = self
        }
    }
    
    //MARK: - Actions
    @IBAction func addPostButtonTapped(_ sender: UIButton) {
        
        guard let caption = captionTextField.text, !caption.isEmpty,
              let photo = selectedImage else {return}
        
        PostController.shared.createPostWith(photo: photo, caption: caption) { (post) in }
        
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func cancelBarButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
}//End of class

//MARK: - Extensions
extension AddPostTableViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectorViewControllerSelected(image: UIImage) {
        selectedImage = image
    }
}//End of extension

