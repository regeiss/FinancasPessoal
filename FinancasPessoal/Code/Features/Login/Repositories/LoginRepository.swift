//
//  LoginRepository.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 09/01/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class LoginRepository: ObservableObject
{
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid
    
    @Published var login = [Login]()
    
    func loadData()
    {
        db.collection("login")
            .whereField("userId", isEqualTo: userId as Any)
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot
                {
                    self.login = querySnapshot.documents.compactMap { document in
                        try? document.data(as: Login.self)
                    }
                }
            }
    }
}
