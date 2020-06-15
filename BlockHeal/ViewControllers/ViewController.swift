//
//  ViewController.swift
//  BlockHeal
//
//  Created by ali on 5/19/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import UIKit
import SawtoothSigning
import RxSwift


class ViewController: UIViewController {
    
    var APIDispposableTransaction: Disposable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sendPrescriptTransactiion = TransactionHelper.sendPrescript(recieverPublicKeyHex: "jdjhjdhjhdhjdjhdhj", precscript: "{ 'X' : 12, 'Y' : 20 }", index: "1")
        let createAccountTransaction = TransactionHelper.createAccount(role: .Doctor)
        let createAccountTransaction2 = TransactionHelper.createAccount(role: .Patient)

        if let createAccountData = createAccountTransaction {
            APIDispposableTransaction?.dispose()
            APIDispposableTransaction = nil
            APIDispposableTransaction = APIHelper.createAccountTransactiion(body: createAccountData)
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe(onNext: { (response) in
                    Log.i("createAccountTransactiion => Doctor => onNext => \(response)")
                    
                }, onError: { (error) in
                    Log.e("createAccountTransactiion => Doctor => onError => \(error) => \((error as NSError).domain)")
                    
                })
        }
        
        if let createAccountData = createAccountTransaction2 {
            APIDispposableTransaction?.dispose()
            APIDispposableTransaction = nil
            APIDispposableTransaction = APIHelper.createAccountTransactiion(body: createAccountData)
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe(onNext: { (response) in
                    Log.i("createAccountTransactiion => Patiient => onNext => \(response)")
                    
                }, onError: { (error) in
                    Log.e("createAccountTransactiion =>  Patiient => onError => \(error) => \((error as NSError).domain)")
                    
                })
        }

    }
}


