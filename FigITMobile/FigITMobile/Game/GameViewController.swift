//
//  GameViewController.swift
//  FigITMobile
//
//  Created by Charmaine Suah on 15/11/2024.
//


import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func loadView() {
        self.view = SKView() // Ensure the view is set as an SKView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as? SKView {
            // Load the GameScene programmatically instead of relying on GameScene.sks
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill

            // Present the scene
            view.presentScene(scene)

            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        } else {
            print("The view is not an SKView.")
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
