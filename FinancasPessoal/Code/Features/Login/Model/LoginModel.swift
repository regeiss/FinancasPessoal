//
//  LoginModel.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 07/01/24.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseCore

struct Login: Identifiable, Codable
{
    @DocumentID var id: String?
    @ServerTimestamp var criadoEm: Date?
    var login: String
    var password: String
}
