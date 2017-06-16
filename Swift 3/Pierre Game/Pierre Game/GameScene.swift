//
//  GameScene.swift
//  Pierre Game
//
//  Created by Lisa on 6/14/17.
//  Copyright © 2017 Sascha Luna. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let cam = SKCameraNode()
    let ground = Ground()
    let player = Player()
    var screenCenterY = CGFloat()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .zero
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        self.camera = cam
        
        player.position = CGPoint(x: 150, y: 250)
        self.addChild(player)
        
        let bee2 = Bee()
        bee2.position = CGPoint(x: 325, y: 325)
        self.addChild(bee2)
        
        let bee3 = Bee()
        bee3.position = CGPoint(x: 200, y: 325)
        self.addChild(bee3)
        
        ground.position = CGPoint(x: -self.size.width * 2, y: 30)
        ground.size = CGSize(width: self.size.width * 6, height: 0)
        ground.createChildren()
        self.addChild(ground)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        screenCenterY = self.size.height / 2
    }
    
    override func didSimulatePhysics() {
        var cameraYPosition = screenCenterY
        cam.yScale = 1
        cam.xScale = 1
        
        if (player.position.y > screenCenterY) {
            cameraYPosition = player.position.y
            let percentOfMaxHeight = (player.position.y - screenCenterY) / (player.maxHeight - screenCenterY)
            let newScale = 1 + percentOfMaxHeight
            cam.yScale = newScale
            cam.xScale = newScale
        }
        self.camera!.position = CGPoint(x: player.position.x, y: cameraYPosition)
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.update()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            if let gameSprite = nodeTouched as? GameSprite {
                gameSprite.onTap()
            }
        }
    
        player.startFlapping()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopFlapping()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopFlapping()
    }
    
}
