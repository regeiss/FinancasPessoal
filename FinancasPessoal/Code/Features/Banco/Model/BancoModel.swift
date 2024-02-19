//
//  BancoModel.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 07/02/24.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseCore

struct Banco: Identifiable, Codable
{
    @DocumentID var id: String?
    var nome: String
}

extension Banco
{
    static let collectionName = "banco"
}

extension Banco
{
  static let samples = [
    Banco(nome: "Build sample app"),
    Banco(nome: "Create tutorial"),
    Banco(nome: "???"),
    Banco(nome: "PROFIT!"),
  ]
}
