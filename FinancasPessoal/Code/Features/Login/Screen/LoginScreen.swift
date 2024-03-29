//
//  LoginScreen.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 02/01/24.
//

import SwiftUI
import Combine
import FirebaseAnalyticsSwift
import AuthenticationServices
import SwiftUICoordinator

private enum FocusableField: Hashable
{
    case email
    case password
}

struct LoginScreen<Coordinator: Routing>: View
{
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel<Coordinator>()
    
    @EnvironmentObject var viewModelLogin: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    
    private func signInWithEmailPassword()
    {
        Task
        {
            if await viewModelLogin.signInWithEmailPassword() == true
            {
                dismiss()
            }
        }
    }
    
    var body: some View {
        VStack {
            Image("Login")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minHeight: 300, maxHeight: 400)
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Image(systemName: "at")
                TextField("Email", text: $viewModelLogin.email)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($focus, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        self.focus = .password
                    }
            }
            .padding(.vertical, 6)
            .background(Divider(), alignment: .bottom)
            .padding(.bottom, 4)
            
            HStack {
                Image(systemName: "lock")
                SecureField("Password", text: $viewModelLogin.password)
                    .focused($focus, equals: .password)
                    .submitLabel(.go)
                    .onSubmit {
                        signInWithEmailPassword()
                    }
            }
            .padding(.vertical, 6)
            .background(Divider(), alignment: .bottom)
            .padding(.bottom, 8)
            
            if !viewModelLogin.errorMessage.isEmpty {
                VStack {
                    Text(viewModelLogin.errorMessage)
                        .foregroundColor(Color(UIColor.systemRed))
                }
            }
            
            Button(action: signInWithEmailPassword) {
                if viewModelLogin.authenticationState != .authenticating
                {
                    Text("Login")
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                }
                else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                }
            }
            .disabled(!viewModelLogin.isValid)
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            
            HStack {
                VStack { Divider() }
                Text("or")
                VStack { Divider() }
            }
            
            HStack {
                Text("Don't have an account yet?")
                Button(action: { viewModelLogin.switchFlow() })
                {
                    Text("Sign up")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .padding([.top, .bottom], 50)
            
        }
        .listStyle(.plain)
        .padding()
        .analyticsScreen(name: "\(Self.self)")
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
    }
}
