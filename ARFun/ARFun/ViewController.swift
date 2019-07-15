//
//  ViewController.swift
//  ARFun
//
//  Created by Tiwari, Niraj | Nero | OSPD on 2019/07/15.
//  Copyright © 2019 TLabs. All rights reserved.
//

import UIKit
import  ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(config)
        
    }


}

