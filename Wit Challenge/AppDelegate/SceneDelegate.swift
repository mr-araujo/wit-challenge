//
//  SceneDelegate.swift
//  Wit Challenge
//
//  Created by Murillo R. Araújo on 06/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = UINavigationController(rootViewController: ListViewController())
        self.window?.windowScene = windowScene
        self.window?.makeKeyAndVisible()
    }
}
