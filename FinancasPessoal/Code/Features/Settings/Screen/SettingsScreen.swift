//
//  SettingsScreen.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 02/01/24.
//

import SwiftUI
import SwiftUICoordinator

struct SettingsScreen<Coordinator: Routing>: View
{
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel<Coordinator>()
    
    var body: some View
    {
        Text("Settings")
    }
}

extension SettingsScreen
{
    @MainActor class ViewModel<R: Routing>: ObservableObject
     {
         var coordinator: R?

//         func didTapAdd()
//         {
//             coordinator?.handle(AbastecimentoAction.inclusao)
//         }
     }
}
