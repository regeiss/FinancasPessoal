//
//  AutenticadoScreen.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 15/01/24.
//

import SwiftUI
import AuthenticationServices

// see https://michael-ginn.medium.com/creating-optional-viewbuilder-parameters-in-swiftui-views-a0d4e3e1a0ae
extension AutenticadoScreen where Unauthenticated == EmptyView
{
    init(@ViewBuilder content: @escaping () -> Content) 
    {
        self.unauthenticated = nil
        self.content = content
    }
}

struct AutenticadoScreen<Content, Unauthenticated>: View where Content: View, Unauthenticated: View
{
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var presentingLoginScreen = false
    @State private var presentingProfileScreen = false
    
    var unauthenticated: Unauthenticated?
    @ViewBuilder var content: () -> Content
    
    public init(unauthenticated: Unauthenticated?, @ViewBuilder content: @escaping () -> Content) 
    {
        self.unauthenticated = unauthenticated
        self.content = content
    }
    
    public init(@ViewBuilder unauthenticated: @escaping () -> Unauthenticated, @ViewBuilder content: @escaping () -> Content) 
    {
        self.unauthenticated = unauthenticated()
        self.content = content
    }
    
    var body: some View 
    {
        switch viewModel.authenticationState 
        {
        case .unauthenticated, .authenticating:
            VStack 
            {
                if let unauthenticated = unauthenticated 
                {
                    unauthenticated
                }
                else 
                {
                    Text("You're not logged in.")
                }
                Button("Tap here to log in") {
                    viewModel.reset()
                    presentingLoginScreen.toggle()
                }
            }
            .sheet(isPresented: $presentingLoginScreen) 
            {
                AutenticacaoScreen()
                    .environmentObject(viewModel)
            }
        case .authenticated:
            VStack 
            {
                content()
                Text("You're logged in as \(viewModel.displayName).")
                Button("Tap here to view your profile") {
                    presentingProfileScreen.toggle()
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: ASAuthorizationAppleIDProvider.credentialRevokedNotification)) { event in
                viewModel.signOut()
                if let userInfo = event.userInfo, let info = userInfo["info"] {
                    print(info)
                }
            }
            .sheet(isPresented: $presentingProfileScreen) 
            {
                NavigationView 
                {
                    UserProfileScreen()
                        .environmentObject(viewModel)
                }
            }
        }
    }
}
