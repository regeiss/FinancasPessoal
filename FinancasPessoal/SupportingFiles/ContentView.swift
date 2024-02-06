//
//  ContentView.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 16/01/24.
//

import SwiftUI

struct ContentView: View
{
    var body: some View
    {
        NavigationStack
        {
            AutenticadoScreen
            {
                Image(systemName: "number.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(.systemPink))
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .clipped()
                    .padding(4)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                Text("Welcome to Favourites!")
                    .font(.title)
                Text("You need to be logged in to use this app.")
            }
            content: {
                HomeScreen()
                Spacer()
        }
        }
    }
}
