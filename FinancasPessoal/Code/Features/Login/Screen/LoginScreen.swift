//
//  LoginScreen.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 02/01/24.
//

import SwiftUI
import SwiftUICoordinator
import FirebaseFirestoreSwift

struct LoginScreen<Coordinator: Routing>: View
{
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel<Coordinator>()
    
     @State private var login: String = ""
     @State private var password: String = ""
    
    @FirestoreQuery(collectionPath: "usuario") private var usuario: [Login]
    
    var body: some View
    {
        VStack
        {
            Spacer()
            HStack
            {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.gray)
                    .frame(width: 200, height: 65)
                Spacer()
                RoundedRectangle(cornerRadius: 25)
                    .fill(.gray)
                    .frame(width: 200, height: 65)
            }
            Spacer()
            VStack
            {
                TextField(
                    "Login.UsernameField.Title",
                    text: $login
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
            
            
            List (usuario)
            {
                Text($0.login)
                Text($0.password)
                Text($0.id ?? "noId")
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
            Spacer()
            Text("Don't have a login? Sigup!")
            Spacer()
        }
        .onAppear
        {
            viewModel.coordinator = coordinator
//            login = usuario[0].login
//            password = usuario[0].password
        }
        .toolbar 
        {
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
