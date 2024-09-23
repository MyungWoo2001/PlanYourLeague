//
//  NewLeangueController.swift
//  PlanYourLeague00
//
//  Created by Myung Woo on 8/20/24.
//

import UIKit

class NewLeangueController: UITableViewController {
    
    var league: League!

    // MARK: Screen Display
    // first time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImageView.image = UIImage(named: "logo")
    }
    // first time and later
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
        
    // MARK: Logo image and photo update
    @IBOutlet var logoImageView: UIImageView! {
        didSet {
            logoImageView.layer.cornerRadius = 10.0
            logoImageView.clipsToBounds = true
        }
    }
    override func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {(action) in
            
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {(action) in
                    
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            photoSourceRequestController.addAction(cancelAction)
            
            // For Ipad
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableview.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
                
            }
            
            present(photoSourceRequestController, animated: true, completion: nil)
        }
    }
    
    // MARK: Text Field
    @IBOutlet var nameTextView: RounderTextView! {
        didSet {
            nameTextView.tag = 1
            nameTextView.becomeFirstResponder()
            nameTextView.delegate = self
        }
    }
    @IBOutlet var typeTextView: RounderTextView! {
        didSet {
            typeTextView.tag = 2
            typeTextView.delegate = self
        }
    }
    @IBOutlet var addressTextView: RounderTextView! {
        didSet {
            addressTextView.tag = 3
            addressTextView.delegate = self
        }
    }
    @IBOutlet var describeTextView: RounderTextView! {
        didSet {
            describeTextView.tag = 4
            describeTextView.delegate = self
        }
    }
    @IBOutlet var managerNameTextView: RounderTextView! {
        didSet {
            managerNameTextView.tag = 5
            managerNameTextView.delegate = self
        }
    }
    @IBOutlet var managerPhoneTextView: RounderTextView! {
        didSet {
            managerPhoneTextView.tag = 6
            managerPhoneTextView.delegate = self
        }
    }
    @IBOutlet var managerEmailTextView: RounderTextView! {
        didSet {
            managerEmailTextView.tag = 7
            managerEmailTextView.delegate = self
        }
    }
    
        
    // MARK: Football Button - Save new league as a Football league
    @IBAction func footballButtonTapped(sender: UIButton){
        //        if nameTextView.text == "" || typeTextView.text == "" || describeTextView.text == "" {
        //            let alertController = UIAlertController(title: "Sorry", message: "You have to fill all the text fill", preferredStyle: .alert)
        //            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        //            alertController.addAction(alertAction)
        //            present(alertController, animated: true, completion: nil)
        //            return
        //        }
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            league = League(context: appDelegate.persistentContainer.viewContext)
            league.name = nameTextView.text!
            league.type = typeTextView.text!
            league.address = addressTextView.text!
            league.describe = describeTextView.text!
            league.manager = managerNameTextView.text!
            league.phone = managerPhoneTextView.text!
            league.email = managerEmailTextView.text!
            league.summary = ""
            
            if let imageData = logoImageView.image?.pngData(){
                league.image = imageData
            }
            print("Saving data to context...")
            appDelegate.saveContext()
        }
        
        //        if let nextStoryboard = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchTableViewController") as? SearchTableViewController {
        //            self.present(nextStoryboard, animated: true, completion: nil)
        //        }
        
        nameTextView.text = ""
        typeTextView.text = ""
        addressTextView.text = ""
        describeTextView.text = ""
        managerNameTextView.text = ""
        managerPhoneTextView.text = ""
        managerEmailTextView.text = ""
        
        if let textField = view.viewWithTag(7){
            textField.resignFirstResponder()
        }
        if let nextTextField = view.viewWithTag(1){
            nextTextField.becomeFirstResponder()
        }

        
        self.tabBarController?.selectedIndex = 1
    }
}

// MARK: Move onto next text field
extension NewLeangueController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1){
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
}

extension NewLeangueController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            logoImageView.image = selectedImage
            logoImageView.contentMode = .scaleAspectFill
            logoImageView.clipsToBounds = true
        }
        
        dismiss(animated: true, completion: nil)
    }
}
