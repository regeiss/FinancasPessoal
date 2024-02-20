//
//  BancoViewModel.swift
//  FinancasPessoal
//
//  Created by Roberto Edgar Geiss on 07/02/24.
//

import Foundation
import Combine

class BancoViewModel: ObservableObject
{
    @Published var banco = [Banco]()
    @Published var errorMessage: String?
    
    private var bancoRepository: BancoRepository = BancoRepository()
    
    init()
    {
        bancoRepository
            .$banco
            .assign(to: &$banco)
    }
    
    func addBanco(_ banco: Banco)
    {
        do
        {
            try bancoRepository.addBanco(banco)
            errorMessage = nil
        }
        catch
        {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func update(_ banco: Banco)
    {
        do
        {
            try bancoRepository.update(banco)
        }
        catch 
        {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
}
