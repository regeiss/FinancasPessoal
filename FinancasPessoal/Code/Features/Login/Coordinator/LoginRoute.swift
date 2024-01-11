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
    case home
    case signup
    
    var title: String?
    {
        switch self 
        {
        case .login, .home:
            return "Finanças pessoais"
        default:
            return nil
        }
    }
    
    var action: TransitionAction?
    {
        switch self
        {
        case .home, .signup:
            // We have to pass nil for the route presenting a child coordinator.
            return nil
            // return .push(animated: true)
        default:
            return .push(animated: true)
        }
    }
}
