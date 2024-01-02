//
//  MenuInicialView.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 10/12/23.
//

import SwiftUI
import SwiftUICoordinator

struct MenuInicialView<Coordinator: Routing>: View
{
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel<Coordinator>()
    
    var body: some View
    {
        List
        {
            Button {
                viewModel.didTapBuiltIn()
            } label: {
                Text("Simple")
            }
            Button {
                viewModel.didTapBuiltIn()
            } label: {
                Text("Simple")
            }
            Button {
                viewModel.didTapBuiltIn()
            } label: {
                Text("Simple")
            }
        }.onAppear {
            viewModel.coordinator = coordinator }
    }
}

extension MenuInicialView
{
    @MainActor class ViewModel<R: Routing>: ObservableObject
    {
        var coordinator: R?
        
        func didTapBuiltIn()
        {
//            coordinator?.handle(ShapesAction.simpleShapes)
        }
    }
}
