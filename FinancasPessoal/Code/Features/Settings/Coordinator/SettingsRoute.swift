//
//  SettingsRoute.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 02/01/24.
//

import Foundation
import SwiftUICoordinator

enum SettingsRoute: NavigationRoute
{
    case settings
    
    var title: String?
      {
          switch self
          {
          case .settings:
              return "Ajustes"
          }
      }
      
      var action: TransitionAction?
      {
          switch self
          {
          case .settings:
              return .present(delegate: SlideTransitionDelegate())
//          default:
//              return .push(animated: true)
          }
      }
}
