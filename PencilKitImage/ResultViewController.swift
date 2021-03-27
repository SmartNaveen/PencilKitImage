//
//  ResultViewController.swift
//  PencilKitImage
//
//  Created by Mr. Naveen Kumar on 27/03/21.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var backButtonTapped: UIBarButtonItem!
    @IBOutlet weak var saveImageButtonTapped: UIBarButtonItem!
    
    var resultImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        resultImageView.image = resultImage
        
        // add aciton of button
        backButtonTapped.action = #selector(backButtonPressed)
        saveImageButtonTapped.action = #selector(saveImageButtonPressed)
    }


    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func saveImageButtonPressed() {
        UIImageWriteToSavedPhotosAlbum(self.resultImage!, nil, nil, nil);
    }
}
