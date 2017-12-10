//
//  ViewController.swift
//  ARTVApp
//
//  Created by Hyeongjin Um on 10/18/17.
//  Copyright © 2017 Hyeongjin Um. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

import SpriteKit
import AVFoundation


class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        let scene = SCNScene()
        sceneView.scene = scene
        // to play animations associated with the scene
        sceneView.isPlaying = true
        
        //1. Create a spriteKit video node and specify which video we wnat to play.
        // to play video we meed spritekit
        let spriteKitScene = SKScene(size: CGSize(width: sceneView.frame.width, height: sceneView.frame.height))
        spriteKitScene.scaleMode = .aspectFit
        
        //video player : is responsible for the playback of the video material.
        let videoUrl = Bundle.main.url(forResource: "video", withExtension: "mp4")!
        let videoPlayer = AVPlayer(url: videoUrl)
        
        //create a Scenekit plane and add the Spritekit scene as its material
        let videoSpriteKitNode = SKVideoNode(avPlayer: videoPlayer)
        //  centerPoint
        
        videoSpriteKitNode.position = CGPoint(x: spriteKitScene.size.width / 2.0, y: spriteKitScene.size.height / 2.0)
        videoSpriteKitNode.size = spriteKitScene.size
        //prevent upside down
        videoSpriteKitNode.yScale = -1.0
        videoSpriteKitNode.play()
        spriteKitScene.addChild(videoSpriteKitNode)
        
        
       

        //2. Create a scenekit and andd the spritekit scene as its material.
        let background = SCNPlane(width: CGFloat(0.288*2), height: CGFloat(0.18*2))
        background.firstMaterial?.diffuse.contents = spriteKitScene
        let backgroundNode = SCNNode(geometry: background)
        backgroundNode.position = SCNVector3(0, 0, -1)
        
        let backgroundBox = SCNBox(width: 0.288*2*1.1, height: 0.18*2*1.1, length: 0.025, chamferRadius: 0)
        backgroundBox.firstMaterial?.diffuse.contents = UIColor.black
        let backgroundBoxNode = SCNNode(geometry: backgroundBox)
        backgroundBoxNode.position = SCNVector3(0, 0, -1.013)
        
        
        //3. add the tv to our scene.
        scene.rootNode.addChildNode(backgroundNode)
        scene.rootNode.addChildNode(backgroundBoxNode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
  
}
