//
//  LoginRoute.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 01/01/24.
//

import Foundation
import SwiftUICoordinator

enum LoginRoute: NavigationRoute
{
    case login
    
    var title: String?
    {
        switch self {
        case .login:
            return "SwiftUI Shapes"
        default:
            return nil
        }
    }
    
    var action: TransitionAction?
    {
        switch self
        {
        case .login:
            // We have to pass nil for the route presenting a child coordinator.
            return nil
        default:
            return .push(animated: true)
        }
    }
}
