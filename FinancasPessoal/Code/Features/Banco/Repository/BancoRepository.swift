//
//  LoginRepository.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 09/01/24.
//

import Foundation
import Factory
import FirebaseFirestore
import FirebaseFirestoreSwift

class BancoRepository: ObservableObject
{
    @Injected(\.firestore) var firestore
    @Published var banco = [Banco]()
    private var listenerRegistration: ListenerRegistration?
    
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
                    self?.banco = documents.compactMap { queryDocumentSnapshot in
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
        try firestore
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
        
        try firestore
            .collection(Banco.collectionName)
            .document(documentId)
            .setData(from: banco, merge: true)
    }
    
    func delete(_ banco: Banco)
    {
        guard let documentId = banco.id
        else
        {
            fatalError("Reminder \(banco.nome) has no document ID.")
        }
        
        firestore
            .collection(Banco.collectionName)
            .document(documentId)
            .delete()
    }
}
