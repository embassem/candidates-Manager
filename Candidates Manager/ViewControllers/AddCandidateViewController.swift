//
//  AddCandidateViewController.swift
//  Candidates Manager
//
//  Created by Bassem Abbas on 5/16/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift

class AddCandidateViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var positionTextField: UITextField!
    
    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var candedateImageView: UIImageView!

    @IBOutlet weak var usermap: MKMapView!
    
    let picker = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }


    
    @IBAction func saveAction(_ sender: Any) {
        
        // TODO: VAlidation Layer
        
        if (true == true) {
            
            self.save()
        }else {
            
            //TODO: Alert Not Valid Input
            
        }
        
    }
    
    
    func save(){
        
        let candidate = Candidate(position: self.positionTextField.text!, mobile: self.mobileTextField.text!, name: self.nameTextField.text!);
        
        
        if let photo = candedateImageView.image{
            
            if let scaledimage = Helper.Image.scaleImage(photo, width: 200){
                
                if let imageData =  UIImagePNGRepresentation(scaledimage) {
                    
                    candidate.photo = imageData;
                }
                
            }
            
            
        }
        
        
        let center = usermap.centerCoordinate ;
        candidate.locationLat = center.latitude;
        candidate.locationLong = center.longitude;

        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(candidate)
            }
            
            alertSaveSuccess();
            
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
        
    }
    
    
    
    func alertSaveSuccess(){
        
        let alert = UIAlertController(title: "Alert", message: "Save Success", preferredStyle: UIAlertControllerStyle.alert);
        let cancel = UIAlertAction(title: "Ok   ", style: UIAlertActionStyle.cancel, handler: { (cancelAction) in
            
            DispatchQueue.main.async {
                
                self.navigationController?.popViewController(animated: true);

            }
            
            
        })
        alert.addAction(cancel);
        self.present(alert, animated: true, completion: nil);
        

        
    }
    
    @IBAction func alertForImagePick(sender:UIButton){
        
        
        let alert = UIAlertController(title: "Choose",
                                      message: "",
                                      preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let libraryAction =  UIAlertAction(title: "Library", style: UIAlertActionStyle.default) { (action) in
            self.photoFromLibrary();
        }
        
        
        let cameraAction =  UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (action) in
            self.shootPhoto();
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil);
        
        
        alert.addAction(libraryAction);
        alert.addAction(cameraAction);

        alert.addAction(cancel);

        
       
        
        self.present(alert, animated: true, completion: nil);
        
        
    }
    
    
    
        @IBAction func photoFromLibrary() {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
            //picker.popoverPresentationController?.barButtonItem = sender
        }

        @IBAction func shootPhoto() {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker, animated: true, completion: nil)
            } else {
                noCamera()
            }
        }
        func noCamera() {
            let alertVC = UIAlertController(
                title: "No Camera",
                message: "Sorry, this device has no camera",
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil)
            alertVC.addAction(okAction)
            present(
                alertVC,
                animated: true,
                completion: nil)
        }
    

        //MARK: - Delegates
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [String: AnyObject])
        {
            var chosenImage = UIImage()
            chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            candedateImageView.contentMode = .scaleAspectFit //3
            candedateImageView.image = chosenImage //4
            dismiss(animated: true, completion: nil) //5
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }



}
