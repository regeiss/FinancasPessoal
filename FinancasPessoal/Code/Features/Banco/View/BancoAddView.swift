//
//  AddBancoView.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 18/02/24.
//

import SwiftUI

struct BancoAddView: View
{
    enum FocusableField: Hashable
    {
        case nome
    }
    
    enum Mode 
    {
        case add
        case edit
    }

    var mode: Mode = .add
    @FocusState private var focusedField: FocusableField?
    @State var banco = Banco(nome: "")
    @Environment(\.dismiss) private var dismiss
    
    let onCommit: (_ banco: Banco) -> Void
    
    private func commit()
    {
        onCommit(banco)
        dismiss()
    }
    
    private func cancel()
    {
        dismiss()
    }
    
    var body: some View 
    {
        NavigationStack 
        {
            Form 
            {
                TextField("Nome", text: $banco.nome)
                    .focused($focusedField, equals: .nome)
            }
            .navigationTitle("New Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: cancel) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: commit) {
                        Text("Add")
                    }
                    .disabled(banco.nome.isEmpty)
                }
            }
            .onAppear 
            {
                focusedField = .nome
            }
        }
    }
}
