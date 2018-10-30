/**
 Copyright 2017 IBM Corp. All Rights Reserved.
 Licensed under the Apache License, Version 2.0 (the 'License'); you may not
 use this file except in compliance with the License. You may obtain a copy of
 the License at
 http://www.apache.org/licenses/LICENSE-2.0
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an 'AS IS' BASIS, WITHOUT
 WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 License for the specific language governing permissions and limitations under
 the License.
 */

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
