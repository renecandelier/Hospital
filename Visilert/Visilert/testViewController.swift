//
//  testViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 2/12/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit
import SceneKit

class testViewController: UIViewController {

    @IBOutlet weak var carObject: SCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: -3.0, y: 3.0, z: 3.0)
//        let bundle = NSBundle.mainBundle()
//        let path = bundle.pathForResource("Avent", ofType: "obj")
//        let url = NSURL(fileURLWithPath: path!)
//        let asset = MDLAsset(URL: url)
//        let torusModel = MDLAsset(URL: NSURL.fileURLWithPath(path!))
//        let obj = SCNScene(URL: url, options: <#T##[String : AnyObject]?#>)
//        let scene = SCNScene(MDLAsset: asset)
        // Do any additional setup after loading the view.
        
        
        let scene = SCNScene(named: "Avent.obj")!
//        let sceneView = self.view as! SCNView
//        sceneView.scene = scene

    carObject.scene = scene
        
        carObject.backgroundColor = UIColor.blackColor()
        carObject.autoenablesDefaultLighting = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "sceneTapped:")
        let gestureRecognizers = NSMutableArray()
        gestureRecognizers.addObject(tapGesture)
        if let arr = carObject.gestureRecognizers { gestureRecognizers.addObjectsFromArray(arr) }
        carObject.gestureRecognizers = gestureRecognizers as? [UIGestureRecognizer]
        carObject.allowsCameraControl = true
//
//        
//        let tapRecognizer = UITapGestureRecognizer()
//        tapRecognizer.numberOfTapsRequired = 1
//        tapRecognizer.numberOfTouchesRequired = 1
//        tapRecognizer.addTarget(self, action: "sceneTapped:")
//        carObject.gestureRecognizers = [tapRecognizer]
//        let camera = SCNCamera()
//        cameraNode.position = SCNVector3(x: -3.0, y: 3.0, z: 3.0)
//        camera.usesOrthographicProjection = true
//        camera.orthographicScale = 9
//        camera.zNear = 0
//        camera.zFar = 100
//        let cameraNode = SCNNode()
//        cameraNode.position = SCNVector3(x: 0, y: 0, z: 50)
//        cameraNode.camera = camera
//        let cameraOrbit = SCNNode()
//        cameraOrbit.addChildNode(cameraNode)
//        carObject.rootNode.addChildNode(cameraOrbit)
//        
//        // rotate it (I've left out some animation code here to show just the rotation)
//        carObject.eulerAngles.x -= CGFloat(M_PI_4)
//        cameraOrbit.eulerAngles.y -= CGFloat(M_PI_4*3)
        
    }
    func sceneTapped(recognizer: UITapGestureRecognizer) {
        let location = recognizer.locationInView(carObject)
        
        let hitResults = carObject.hitTest(location, options: nil)
        if hitResults.count > 0 {
            let result = hitResults[0] as SCNHitTestResult
            let node = result.node
            node.removeFromParentNode()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
