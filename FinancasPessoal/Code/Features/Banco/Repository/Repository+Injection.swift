//
//  Repository+Injection.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 24/02/24.
//

import Foundation
import Factory

extension Container
{
    public var bancoRepository: Factory<BancoRepository>
    {
        Factory(self)
        {
            BancoRepository()
        }
        .singleton
    }
}
