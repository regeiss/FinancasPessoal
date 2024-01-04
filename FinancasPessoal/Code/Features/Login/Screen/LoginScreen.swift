//
//  LoginScreen.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 02/01/24.
//

import SwiftUI
import SwiftUICoordinator

struct LoginScreen<Coordinator: Routing>: View
{
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel<Coordinator>()
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View
    {
        VStack
        {
            Spacer()
            VStack
            {
                TextField(
                    "Login.UsernameField.Title",
                    text: $username
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
                
                SecureField(
                    "Login.PasswordField.Title",
                    text: $password
                )
                .padding(.top, 20)
                
                Divider()
            }
            Spacer()
            Button
            { viewModel.didTapLogin() }
        label: {
            Text("Login")
                .font(.system(size: 24, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, maxHeight: 60)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(10) }
        }
        .onAppear
        { viewModel.coordinator = coordinator }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing)
            { Button { viewModel.didTapSettings()}
                label: { Image(systemName: "gear")}}
        }
        .padding()
    }
}

extension LoginScreen
{
    @MainActor class ViewModel<R: Routing>: ObservableObject
    {
        var coordinator: R?
        
        func didTapLogin()
        {
            coordinator?.handle(LoginAction.home)
        }
        
        func didTapSettings()
        {
            coordinator?.handle(LoginAction.settings)
        }
    }
}
