//
//  ViewController.swift
//  HotDogNotHotDog
//
//  Created by Sanjeev Ghimire on 10/30/18.
//  Copyright © 2018 Sanjeev Ghimire. All rights reserved.
//

import UIKit
import Lumina

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let camera = LuminaViewController()
        LuminaViewController.loggingLevel = .info
        camera.delegate = self
        camera.streamingModels = [LuminaModel(model: seefood().model, type: "See Food")]
        present(camera,animated: true,completion: nil)
    }

}

extension ViewController: LuminaDelegate{
    func dismissed(controller: LuminaViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func streamed(videoFrame: UIImage, with predictions: [LuminaRecognitionResult]?, from controller: LuminaViewController) {
        if #available(iOS 11.0, *) {
            guard let predicted = predictions else {
                return
            }            
            guard let value = predicted.first?.predictions?.first else {
                return
            }
            if value.confidence > 0 {
                controller.textPrompt = "Not Hot Dog"
            } else {
                controller.textPrompt = "Hot Dog"
            }
        } else {
            print("CoreML not available in iOS 10.0")
        }
    }
}
