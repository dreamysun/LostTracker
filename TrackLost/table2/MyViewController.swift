//
//  ViewController.swift
//  table2
//
//  Created by Dreamy Sun on 2/19/19.
//  Copyright © 2019 ChenyuSun. All rights reserved.
//


import UIKit



class MyViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var SelectPic: UIButton!
   
    
    
    
 
    var imageURL: URL?
    
    
    var didSaveElement:((_ element:Element) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [.foregroundColor: UIColor.white]

        self.navigationController?.navigationBar.tintColor = UIColor.white
        

        self.view.layer.contents = UIImage(named:"water.jpg")!.cgImage
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    @IBAction func SelectPic(_ sender: Any) {
   
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
    
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary

            self.present(picker, animated: true, completion: {
                () -> Void in
                
            })
        }else{
            print("errorrrrrrrr")
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }

        self.imageURL = imageURL

        
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })

        
//        guard let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
//            print(">>>>>>>>")
//            print("imageUrl", imageUrl)
//        }

    
        print(info)
        
   
        let image: UIImage!
            image = info[.originalImage] as? UIImage
        
        pic.image = image
        pic.isHidden = false
        SelectPic.isHidden = true
        
 
    }
    
    
    @IBAction func handelSaveButton(_ sender: Any) {
        
        let dateString = NSDate().description
       // let picString = pic.image
        
        
        // Pass back data.
        let element = Element(date: dateString, message: text.text!, imageURL: self.imageURL)
        didSaveElement?(element)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismisses keyboard when done is pressed.
      //  textField.resignFirstResponder()
        view.endEditing(true)
        return false
    }
    
}

