//
//  DetailViewController.swift
//  DogBreedIdentification
//
//  Created by Chitrala Dhruv on 23/07/21.
//

import UIKit

class DetailViewController: UIViewController,UIAlertViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    private let classifier = ImageClassifier()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    
    @IBAction func cameraOnClicked(_ sender: Any) {
        self.showCamera()
    }
    @IBAction func albumOnCLicked(_ sender: Any) {
        self.showAlbum()
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        
        present(cameraPicker, animated: true)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .photoLibrary
        
        present(cameraPicker, animated: true)
        
    }
    
    @IBAction func onShare(_ sender: Any) {
        
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, 0);
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
           let cgImage = image.cgImage {
            classifier.classifyImageWithVision(image: cgImage) { (results) in
                DispatchQueue.main.async {
                    self.predictionLabel.text = results
                    self.imageView.image = image
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
