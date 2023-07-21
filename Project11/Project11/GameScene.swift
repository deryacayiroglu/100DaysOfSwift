//
//  GameScene.swift
//  Project11
//
//  Created by Derya Çayıroğlu on 21.07.2023.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
       let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
    }
}
