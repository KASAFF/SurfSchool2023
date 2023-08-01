//
//  SceneDelegate.swift
//  SurfSchoolTest2023
//
//  Created by Aleksey Kosov on 01.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)

        window.rootViewController = createNavigationController()
        self.window = window
        window.makeKeyAndVisible()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    private func createNavigationController() -> UINavigationController {
        let userProfileVC = UserProfileViewController()
        userProfileVC.title = "Профиль"
        let navigationVC = UINavigationController(rootViewController: userProfileVC)
        return navigationVC
    }
}

