//
//  Firebase+Injection.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 23/02/24.
//

import Foundation
import Factory
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


extension Container
{
    public var useEmulator: Factory<Bool>
    {
        Factory(self) {
            let value =  UserDefaults.standard.bool(forKey: "useEmulator")
            print("Using the emulator: \(value == true ? "YES" : "NO")")
            return value
        }.singleton
    }
    
    public var firestore: Factory<Firestore>
    {
        Factory(self) {
            var environment = ""
            if Container.shared.useEmulator() {
                let settings = Firestore.firestore().settings
                settings.host = "localhost:8080"
                settings.cacheSettings = MemoryCacheSettings()
                settings.isSSLEnabled = false
                environment = "to use the local emulator on \(settings.host)"
                
                
                Firestore.firestore().settings = settings
                Auth.auth().useEmulator(withHost: "localhost", port: 9099)
            }
            else {
                environment = "to use the Firebase backend"
            }
            print("Configuring Cloud Firestore \(environment).")
            return Firestore.firestore()
        }.singleton
    }
}
