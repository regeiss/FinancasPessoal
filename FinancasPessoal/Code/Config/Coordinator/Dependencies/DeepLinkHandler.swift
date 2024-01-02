//
//  DeepLinkHandler.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 10/12/23.
//

import Foundation
import SwiftUICoordinator

class DeepLinkHandler: DeepLinkHandling 
{
    static let shared = DeepLinkHandler()
    
    let scheme = "coordinatorexample"
    let links: Set<DeepLink> = [
        DeepLink(action: "custom", route: LoginRoute.login)
    ]
    
    private init() {}
}
