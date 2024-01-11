//
//  LoginCoordinator.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 01/01/24.
//

import SwiftUI
import SwiftUICoordinator

class LoginCoordinator: Routing
{
    // MARK: - Internal properties
    
    weak var parent: Coordinator?
    var childCoordinators = [WeakCoordinator]()
    let navigationController: NavigationController
    let startRoute: LoginRoute
    let factory: CoordinatorFactory
    
    init(
        parent: Coordinator?,
        navigationController: NavigationController,
        startRoute: LoginRoute = .login,
        factory: CoordinatorFactory
    ) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
        self.factory = factory
    }
    
    func handle(_ action: CoordinatorAction)
    {
        switch action 
        {
        case LoginAction.login:
            let coordinator = factory.makeLoginCoordinator(parent: self)
            try? coordinator.start()
            
        case LoginAction.home:
            let coordinator = factory.makeHomeCoordinator(parent: self)
            try? coordinator.start()
            
        case LoginAction.signup:
            let coordinator = factory.makeSettingsCoordinator(parent: self)
            try? coordinator.start()
            
        case Action.done(_):
            popToRoot()
            childCoordinators.removeAll()
        default:
            parent?.handle(action)
        }
    }
}

extension LoginCoordinator: RouterViewFactory
{
    @ViewBuilder
    public func view(for route: LoginRoute) -> some View
    {
        switch route
        {
        case .login:
            LoginScreen<LoginCoordinator>()
        case .home:
            HomeScreen<HomeCoordinator>()
        case .signup:
            SettingsScreen<SettingsCoordinator>()
        }
    }
}
