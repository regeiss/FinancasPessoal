//
//  LoginRepository.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 09/01/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class BancoRepository: ObservableObject
{
    
//    let dbf = Firestore.firestore()
//    let userId = Auth.auth().currentUser?.uid
    private var listenerRegistration: ListenerRegistration?
    
    @Published var banco = [Banco]()
    
    init()
    {
        subscribe()
    }
    
    deinit
    {
        unsubscribe()
    }
    
    func subscribe()
    {
        if listenerRegistration == nil 
        {
            let query = Firestore.firestore().collection(Banco.collectionName)
            
            listenerRegistration = query
                .addSnapshotListener { [weak self] (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents 
                    else
                    {
                        print("No documents")
                        return
                    }
                    
                    print("Mapping \(documents.count) documents")
                    documents.compactMap { queryDocumentSnapshot in
                        do 
                        {
                            return try queryDocumentSnapshot.data(as: Banco.self)
                        }
                        catch 
                        {
                            print("Error while trying to map document \(queryDocumentSnapshot.documentID): \(error.localizedDescription)")
                            return nil
                        }
                    }
            }
        }
    }
    
    private func unsubscribe()
    {
        if listenerRegistration != nil
        {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func addBanco(_ banco: Banco) throws
    {
        try Firestore
            .firestore()
            .collection(Banco.collectionName)
            .addDocument(from: banco)
        
    }
    
    func update(_ banco: Banco) throws
    {
        guard let documentId = banco.id
        else
        {
            fatalError("Banco \(banco.nome) has no document ID.")
        }
        
        try Firestore
            .firestore()
            .collection(Banco.collectionName)
            .document(documentId)
            .setData(from: banco, merge: true)
    }
    
    
    
//    func loadData()
//    {
//        dbf.collection("banco")
//            .whereField("id", isEqualTo: userId as Any)
//            .addSnapshotListener { (querySnapshot, error) in
//                if let querySnapshot = querySnapshot
//                {
//                    self.banco = querySnapshot.documents.compactMap { document in
//                        try? document.data(as: Banco.self)
//                    }
//                }
//            }
//    }
}
