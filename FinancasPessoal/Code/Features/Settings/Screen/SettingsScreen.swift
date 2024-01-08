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
        VStack
        {
            Text("Settings")
        }
        .onAppear{ viewModel.coordinator = coordinator}
        .toolbar(content: {
            ToolbarItem {
                Button { viewModel.didTapClose()}
            label: { Label("Dismiss", systemImage: "xmark.circle.fill")}
            }
            
        })
    }
}

extension SettingsScreen
{
    @MainActor class ViewModel<R: Routing>: ObservableObject
    {
        var coordinator: R?
        
        func didTapClose()
        {
            coordinator?.pop(animated: true)
        }
    }
}
