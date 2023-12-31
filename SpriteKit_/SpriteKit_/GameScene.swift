//
//  GameScene.swift
//  SpriteKit_
//
//  Created by Mac on 25/09/2023.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var backGroundImage = SKSpriteNode(imageNamed: "background")
    
    var snakeNode = SKSpriteNode(imageNamed: "snakeIcon")
    
    var antsNodeArray = ["antsIcon1", "antsIcon2", "antsIcon3", "antsIcon4", "antsIcon5", "antsIcon6", "antsIcon7", "antsIcon8", "antsIcon9", "antsIcon10"]
    
    public override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        settingBackgroundImage()
        createSnakeNode()
        createAntsNode()
    }
    
    //MARK: - Positioning the background image
    func settingBackgroundImage() {
        backGroundImage.position = CGPoint(x: 0, y: 0)
        backGroundImage.size.width = self.size.width
        backGroundImage.size.height = self.size.height
        backGroundImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(backGroundImage)
        backGroundImage.scene?.scaleMode = .aspectFill
        backGroundImage.zPosition = -1
    }
    
    //MARK: - Positioning the icon
    func createSnakeNode() {
        snakeNode.zPosition = 1
        snakeNode.color = SKColor.black
        snakeNode.colorBlendFactor = 1.0
        snakeNode.position = CGPoint(x: -120, y: 50)
        let iconSize = CGSize(width: 90, height: 90)
        snakeNode.size = iconSize
        addChild(snakeNode)
    }
    
    //MARK: - Positioning the icon
    public func createAntsNode() {
        for i in antsNodeArray {
            let antsNode = SKSpriteNode(imageNamed: i)
            antsNode.zPosition = 1
            antsNode.color = SKColor.black
            antsNode.colorBlendFactor = 1.0
            antsNode.anchorPoint = CGPoint(x: 2.5, y: 2.5)
            antsNode.position = CGPoint(x: CGFloat.random(in: 0..<200), y: CGFloat.random(in: 0..<300))
            let iconSize = CGSize(width: 30, height: 30)
            antsNode.size = iconSize
            antsNode.removeFromParent()
            addChild(antsNode)
            
            let yourDistance: CGFloat = 300.0
            let yourDuration: TimeInterval = 2.0
            let moveOffscreen = SKAction.move(by: CGVector(dx: 0, dy: -yourDistance), duration: yourDuration)
            let moveOnScreen = SKAction.move(by: CGVector(dx: 0, dy: yourDistance), duration: yourDuration)
            let moveSequence = SKAction.sequence([moveOffscreen, SKAction.run{
                
            },
                                                  moveOnScreen, SKAction.run{
                
            }    ])
            let repeatAction = SKAction.repeatForever(moveSequence)
            antsNode.run(repeatAction)
        }
        
    }
    
    //MARK: - The Method that trigger the movement of the icon
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            _ = touch.location(in: self)
        }
        shootAntsNode()
    }
    
    //MARK: - The Method that trigger the movement of the icon
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            snakeNode.position.x = (location.x)
        }
    }
    
    //MARK: - This function shoots at the ants when its called in the touchbegan method
    func shootAntsNode() {
        let projectile = SKSpriteNode(imageNamed: "fireIcon")
        projectile.size = CGSize(width: 40, height: 40)
        projectile.position = snakeNode.position
        
        let destination = CGPoint(x: size.width, y: snakeNode.position.y)
        let moveAction = SKAction.move(to: destination, duration: 0.5)
        
        let removeAction = SKAction.removeFromParent()
        
        projectile.name = "projectile"
        
        projectile.isUserInteractionEnabled = true
        
        let sequence = SKAction.sequence([moveAction, removeAction])
        
        projectile.run(sequence)
        addChild(projectile)
    }
    
}
