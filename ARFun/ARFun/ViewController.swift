import UIKit
import  ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(self.config)
        self.sceneView.autoenablesDefaultLighting = true
        self.addTapGestureToSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sceneView.session.run(self.config)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.sceneView.session.pause()
    }
    
    @IBAction func addNode(_ sender: Any) {
        addNode()
    }
    
    func addNode() {
        let boxNode = SCNNode()
        let cylinderNode = SCNNode(geometry: SCNCylinder(radius: 0.05, height: 0.05))
        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        boxNode.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        boxNode.geometry?.firstMaterial?.specular.contents = UIColor.white
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
        
        boxNode.position = SCNVector3(0.2 ,0.3 ,-0.2)
        cylinderNode.position = SCNVector3(-0.3, 0.2, -0.3)
        let scene  = SCNScene()
        scene.rootNode.addChildNode(boxNode)
        boxNode.addChildNode(cylinderNode)
        sceneView.scene = scene
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(withGestureRecognizer:)) )
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        
        guard let node = hitTestResults.first?.node else { return }
        node.removeFromParentNode()
    }
    
    @IBAction func resetScene(_ sender: Any) {
        restartSession()
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }
}
