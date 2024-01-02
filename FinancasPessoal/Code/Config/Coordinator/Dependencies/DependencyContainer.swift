//
//  DependencyContainer.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 10/12/23.
//

import SwiftUI
import SwiftUICoordinator

@MainActor
final class DependencyContainer
{
    let factory = NavigationControllerFactory()
    lazy var delegate = factory.makeNavigationDelegate([FadeTransition()])
    lazy var navigationController = factory.makeNavigationController(delegate: delegate)
    
    let deepLinkHandler = DeepLinkHandler.shared
    
    private(set) var appCoordinator: AppCoordinator?
    
    func set(_ coordinator: AppCoordinator)
    {
        guard appCoordinator == nil
        else { return }
        
        self.appCoordinator = coordinator
    }
}

extension DependencyContainer: CoordinatorFactory
{
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator
    {
        return AppCoordinator(
            window: window,
            navigationController: self.navigationController
        )
    }
    
    func makeLoginCoordinator(parent: Coordinator) -> LoginCoordinator
    {
        return LoginCoordinator(
            parent: parent,
            navigationController: self.navigationController,
            factory: self
        )
    }
    
    func makeHomeCoordinator(parent: Coordinator) -> HomeCoordinator
    {
        return HomeCoordinator(
            parent: parent,
            navigationController: self.navigationController
        )
    }
    
    func makeSettingsCoordinator(parent: Coordinator) -> SettingsCoordinator
    {
        return SettingsCoordinator(
            parent: parent,
            navigationController: self.navigationController
        )
    }
}

extension DependencyContainer
{
    static let mock = DependencyContainer()
}

