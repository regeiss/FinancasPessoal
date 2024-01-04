//
//  SettingsCoordinator.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 02/01/24.
//

import SwiftUI
import SwiftUICoordinator

class SettingsCoordinator: Routing
{
    // MARK: - Internal properties
    
    weak var parent: Coordinator?
    var childCoordinators = [WeakCoordinator]()
    let navigationController: NavigationController
    let startRoute: SettingsRoute
    let factory: CoordinatorFactory
    
    // MARK: - Initialization
    
    init(
        parent: Coordinator?,
        navigationController: NavigationController,
        startRoute: SettingsRoute = .settings,
        factory: CoordinatorFactory
    ) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
        self.factory = factory
    }
    
    func handle(_ action: CoordinatorAction)
    {
    }
}

extension SettingsCoordinator: RouterViewFactory
{
    @ViewBuilder
    public func view(for route: SettingsRoute) -> some View
    {
        switch route
        {
        case .settings:
            SettingsScreen<SettingsCoordinator>()
        }
    }
}
