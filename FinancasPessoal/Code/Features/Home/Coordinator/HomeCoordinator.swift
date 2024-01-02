//
//  HomeCoordinator.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 02/01/24.
//

import SwiftUI
import SwiftUICoordinator

class HomeCoordinator: Routing
{
    // MARK: - Internal properties
     
     weak var parent: Coordinator?
     var childCoordinators = [WeakCoordinator]()
     let navigationController: NavigationController
     let startRoute: HomeRoute
     let factory: CoordinatorFactory

     // MARK: - Initialization

     init(
         parent: Coordinator?,
         navigationController: NavigationController,
         startRoute: HomeRoute = .home,
         factory: CoordinatorFactory
     ) {
         self.parent = parent
         self.navigationController = navigationController
         self.startRoute = startRoute
         self.factory = factory
     }
}
