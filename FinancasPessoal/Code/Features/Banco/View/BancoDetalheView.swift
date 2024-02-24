//
//  BancoDetalheView.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 18/02/24.
//

import SwiftUI

struct BancoDetalheView: View
{
    @Binding var banco: Banco
    
    var body: some View
    {
        HStack
        {
            Text("Detalhe")
            TextField(banco.nome, text: $banco.nome)
            Spacer()
        }.contentShape(Rectangle())
    }
}
