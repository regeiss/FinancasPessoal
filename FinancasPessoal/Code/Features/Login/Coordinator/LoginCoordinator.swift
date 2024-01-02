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
        switch action {
          case ShapesAction.simpleShapes:
              let coordinator = factory.makeSimpleShapesCoordinator(parent: self)
              try? coordinator.start()
          case ShapesAction.customShapes:
              let coordinator = factory.makeCustomShapesCoordinator(parent: self)
              try? coordinator.start()
          case let ShapesAction.featuredShape(route):
              switch route {
              case let shapeRoute as SimpleShapesRoute where shapeRoute != .simpleShapes:
                  let coordinator = factory.makeSimpleShapesCoordinator(parent: self)
                  coordinator.append(routes: [.simpleShapes, shapeRoute])
              case let shapeRoute as CustomShapesRoute where shapeRoute != .customShapes:
                  let coordinator = factory.makeCustomShapesCoordinator(parent: self)
                  coordinator.append(routes: [.customShapes, shapeRoute])
              default:
                  return
              }
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
             ShapeListView<ShapesCoordinator>()
         case .simpleShapes:
             /// We are returning an empty view for the route presenting a child coordinator.
             EmptyView()
         case .customShapes:
             CustomShapesView<CustomShapesCoordinator>()
         case .featuredShape:
             /// We are returning an empty view for the route presenting a child coordinator.
             EmptyView()
         }
     }
}
