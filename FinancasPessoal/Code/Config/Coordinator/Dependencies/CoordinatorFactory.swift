//
//  CoordinatorFactory.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 10/12/23.
//

import SwiftUI
import SwiftUICoordinator

@MainActor
protocol CoordinatorFactory 
{
    func makeLoginCoordinator(parent: Coordinator) -> LoginCoordinator
    func makeSettingsCoordinator(parent: Coordinator) -> SettingsCoordinator
    func makeHomeCoordinator(parent: Coordinator) -> HomeCoordinator
}

