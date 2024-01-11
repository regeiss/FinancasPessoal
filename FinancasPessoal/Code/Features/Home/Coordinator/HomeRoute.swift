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
    case settings
    
    var title: String?
    {
        switch self 
        {
        case .home:
            return "Home"
        case .settings:
            return "Ajustes"
        }
    }
    
    var action: TransitionAction? 
    {
        switch self 
        {
        case .home:
            return .push(animated: true)
        default:
            return .push(animated: true)
        }
    }
}
