//
//  HomeScreen.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 02/01/24.
//

import SwiftUI
import SwiftUICoordinator

struct HomeScreen<Coordinator: Routing>: View
{
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel<Coordinator>()

    var body: some View
    {
        VStack
        {
            Text("Home")
        }
        .onAppear
        { viewModel.coordinator = coordinator }
            .toolbar
        {
            ToolbarItem(placement: .navigationBarTrailing)
            { Button { viewModel.didTapSettings()}
                label: { Image(systemName: "gear")}}
        }
    }
}

extension HomeScreen
{
    @MainActor class ViewModel<R: Routing>: ObservableObject
     {
         var coordinator: R?

        func didTapSettings()
        {
            coordinator?.handle(HomeAction.settings)
        }
     }
}
