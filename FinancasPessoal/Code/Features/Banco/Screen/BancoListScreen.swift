//
//  BancoListScreen.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 18/02/24.
//

import SwiftUI

struct BancoListScreen: View
{
    @StateObject private var viewModel = BancoViewModel()
    @State private var isAddReminderDialogPresented = false
    @State private var editableBanco: Banco?
    
    private func presentAddReminderView()
    {
        isAddReminderDialogPresented.toggle()
    }
    
    var body: some View
    {
        Text("Lista")
        List($viewModel.banco) { $banco in
            BancoDetalheView(banco: $banco)
                .swipeActions(edge: .trailing, allowsFullSwipe: true)
            {
                Button(role: .destructive, action: { viewModel.delete(banco)})
                {
                    Image(systemName: "trash")
                }
            }
            .onTapGesture
            {
                editableBanco = banco
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar)
            {
                Button(action: presentAddReminderView)
                {
                    HStack
                    {
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                    }
                }
                Spacer()
            }
        }
        .sheet(isPresented: $isAddReminderDialogPresented)
        {
            BancoAddEditView { banco in
                viewModel.addBanco(banco)
            }
        }
        .sheet(item: $editableBanco) { banco in
            BancoAddEditView(banco: banco, mode: .edit) { banco in
                viewModel.update(banco)
            }
        }
        .tint(.red)
    }
}
