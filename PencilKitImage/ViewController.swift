//
//  ViewController.swift
//  PencilKitImage
//
//  Created by Mr. Naveen Kumar on 22/03/21.
//

import UIKit
import PencilKit

class ViewController: UIViewController{

    @IBOutlet weak var canvasView: PKCanvasView!
    var drawing = PKDrawing()
    let toolPicker = PKToolPicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        updateCanvas()
    }
    
    func updateCanvas() {
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
        canvasView.drawingPolicy = .anyInput
    }
    
    @IBAction func clearCanvasButtonTapped(_ sender: UIBarButtonItem) {
        canvasView.drawing = drawing
    }
    
    @IBAction func imageButtonTapped(_ sender: UIBarButtonItem) {
        let image = UIImage(view: canvasView)
        let resultViewController = ResultViewController(nibName: "ResultViewController", bundle: nil)
        resultViewController.resultImage = image
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        toolPicker.setVisible(false, forFirstResponder: canvasView)
        present(imagePicker, animated: true)
    }
    
}

 // MARK:- ImagePicker
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        print(image.size)
    }
}


extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}

