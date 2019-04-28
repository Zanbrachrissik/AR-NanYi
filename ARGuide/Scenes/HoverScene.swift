//
//  HoverScene.swift
//  ARWalkthrough
//
//  Created by Wyszynski, Daniel on 2/18/18.
//  Copyright © 2018 Nike, Inc. All rights reserved.
//

import Foundation
import SceneKit

struct HoverScene {
    
    var scene: SCNScene?
    
    init() {
        scene = self.initializeScene()
    }
    
    func initializeScene() -> SCNScene? {
        let scene = SCNScene()
        
        setDefaults(scene: scene)
        
        return scene
    }
    
    func setDefaults(scene: SCNScene) {
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = SCNLight.LightType.ambient
        ambientLightNode.light?.color = UIColor(white: 0.8, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
        
        // Create a directional light with an angle to provide a more interesting look
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        directionalLight.color = UIColor(white: 0.8, alpha: 1.0)
        let directionalNode = SCNNode()
        directionalNode.eulerAngles = SCNVector3Make(GLKMathDegreesToRadians(-40), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(0))
        directionalNode.light = directionalLight
        scene.rootNode.addChildNode(directionalNode)
    }
    
    func addBuilding(position: SCNVector3) {
        
        guard let scene = self.scene else { return }
        guard let buildingScene = SCNScene(named: "NanYi.dae") else { fatalError("Unable to find NanYi.dae") }
        
        let containerNode = SCNNode()
        
//        let nodesInFile = SCNNode.allNodes(from: "NanYi.dae")
//        nodesInFile.forEach { (node) in
//            containerNode.addChildNode(node)
//        }
        let buildingSceneChildNodes = buildingScene.rootNode.childNodes
        
        for childNode in buildingSceneChildNodes {
            containerNode.addChildNode(childNode)
        }
        containerNode.position = position
        containerNode.scale = SCNVector3(0.5, 0.5, 0.5)
        scene.rootNode.addChildNode(containerNode)
    }
    
    func addText() {
        guard let scene = self.scene else { return }
        
        let text = SCNText(string: "南一楼", extrusionDepth: 0.1)
        text.font = UIFont.systemFont(ofSize: 1.0)
        text.flatness = 0.01
        text.firstMaterial?.diffuse.contents = UIColor.white
        
        let node = SCNNode(geometry: text)
        node.position = SCNVector3(0, 0, -0.3)
        node.scale = SCNVector3(0.1, 0.1, 0.1)
        
        scene.rootNode.addChildNode(node)
    }
}

