//
//  HomeRoute.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 02/01/24.
//

import Foundation
import SwiftUICoordinator

enum HomeRoute: NavigationRoute
{
    case home
    
    var title: String? 
    {
        switch self 
        {
        case .home:
            return "Home"
        default:
            return nil
        }
    }
    
    var action: TransitionAction? 
    {
        switch self 
        {
        case .home:
            // We have to pass nil for the route presenting a child coordinator.
            return nil
        default:
            return .push(animated: true)
        }
    }
}
