//
//  SignInWithAppleButton.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 12/01/24.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: UIViewRepresentable
{
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton
    {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context)
    {
         
    }
    
}
