//
//  AutenticacaoScreen.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 15/01/24.
//

import Combine
import SwiftUI

struct AutenticacaoScreen: View
{
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View
    {
        VStack
        {
            switch viewModel.flow
            {
            case .login:
                LoginScreen()
                    .environmentObject(viewModel)
            case .signUp:
                SignupScreen()
                    .environmentObject(viewModel)
            }
        }
    }
}
