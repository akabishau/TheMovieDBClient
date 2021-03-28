//
//  SceneDelegate.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/8/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = AuthVC()
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print(#function)
        
        guard let url = URLContexts.first?.url else { return }
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if components?.scheme == "themoviedbclient" && components?.path == "authenticate" {
            // get instance of root view controller
            // let welcomeVC = window?.rootViewController as! WelcomeVC
            // call create session method with the completion handler for the response (located on welcome vc)
            AuthManager.createSession { (success) in
                if success {
                    print("SessionId: \(AuthManager.Constants.sessionId)")
                } else {
                    print("WelcomeVC: can't create session id")
                }
            }
        }
    }


}

