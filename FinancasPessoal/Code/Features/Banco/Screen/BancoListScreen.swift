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
    
    private func presentAddReminderView()
    {
        isAddReminderDialogPresented.toggle()
    }
    
    var body: some View
    {
        List($viewModel.banco) { $banco in
            BancoDetalheView(banco: $banco)
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
            BancoDetalheView { banco in
                viewModel.addBanco(banco)
            }
        }
        .tint(.red)
    }
}
