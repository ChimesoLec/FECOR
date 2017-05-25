//
//  ViewController.swift
//  TextRecognition
//
//  Created by Luis Collado on 5/20/17.
//  Copyright © 2017 Luis Collado. All rights reserved.
//

import UIKit
import TesseractOCR
class ViewController: UIViewController,G8TesseractDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBAction func imgGet(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }

    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @nonobjc func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgView.image = pickedImage
            imgView.contentMode = .scaleAspectFit
            if let tesseract = G8Tesseract(language: "eng"){
                tesseract.delegate = self
                // = UIImage(named: "IMG_2804")?.g8_blackAndWhite()
                tesseract.image = pickedImage.g8_blackAndWhite()
                tesseract.recognize()
                textView.text = tesseract.recognizedText
                
            }
        }
        else
        {
            print("Something went wrong!")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Progress \(tesseract.progress) %")
    }

}

