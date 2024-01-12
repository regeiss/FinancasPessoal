//
//  FinancasPessoalApp.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 10/12/23.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct FinancasPessoalApp: App 
{
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene 
    {
           
        WindowGroup
        {
            
        }
    }
}

final class SceneDelegate: NSObject, UIWindowSceneDelegate 
{
    var dependencyContainer = DependencyContainer()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let window = (scene as? UIWindowScene)?.windows.first else {
            return
        }
        
        let appCoordinator = dependencyContainer.makeAppCoordinator(window: window)
        dependencyContainer.set(appCoordinator)
        
        let coordinator = dependencyContainer.makeLoginCoordinator(parent: appCoordinator)
        appCoordinator.start(with: coordinator)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) 
    {
        guard
            let url = URLContexts.first?.url,
            let deepLink = try? dependencyContainer.deepLinkHandler.link(for: url),
            let params = try? dependencyContainer.deepLinkHandler.params(for: url, and: deepLink.params)
        else { return }
        
        dependencyContainer.appCoordinator?.handle(deepLink, with: params)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate 
{
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration
    {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool 
    {
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
        return true
    }
}
