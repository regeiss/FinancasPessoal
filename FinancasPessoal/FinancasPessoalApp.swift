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
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .modifier(DarkModeViewModifier())
            // .withErrorHandling()
        }
        .onChange(of: scenePhase)
        {
            switch scenePhase
            {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
            @unknown default:
                fatalError()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        FirebaseApp.configure()
        return true
    }
}
