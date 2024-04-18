import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate {
    var player: AVPlayer!
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/imageScene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        guard let image = ARReferenceImage.referenceImages(inGroupNamed: "Images", bundle: Bundle.main) else {
            print("No image found")
            return
        }
        configuration.trackingImages = image
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if let imageAnchor = anchor as? ARImageAnchor {
            let imgName = imageAnchor.referenceImage.name
            let videoURL : URL
            switch imgName
            {

            case "Flower":
                videoURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Flower", ofType: "mp4")!)

            case "milkmaid":
                videoURL = URL(fileURLWithPath: Bundle.main.path(forResource: "AnimatedPainting", ofType: "mp4")!)

            case "Starry Night":
                videoURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Starry Night", ofType: "mp4")!)

            case "walkingwoman":

                videoURL = URL(fileURLWithPath: Bundle.main.path(forResource: "walkingwomanp", ofType: "mp4")!)
                
            
            default:
                return nil;
            }
            player = AVPlayer(url: videoURL)
            
            // Loop the video playback
            player.actionAtItemEnd = .none
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak self] _ in
                self?.player.seek(to: CMTime.zero)
                self?.player.play()
            }
            
            let videoPlane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            videoPlane.firstMaterial?.diffuse.contents = player
            
            let videoNode = SCNNode(geometry: videoPlane)
            videoNode.eulerAngles.x = -.pi / 2
            node.addChildNode(videoNode)
            player.play()
        }
        return node
    }
    
    // Remove observer to prevent retain cycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
