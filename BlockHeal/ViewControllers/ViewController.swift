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
import Alamofire


class ViewController: UIViewController {
    
    var APIDispposableTransaction: Disposable!
    

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var label: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let sendPrescriptTransactiion = TransactionHelper.sendPrescript(recieverPublicKeyHex: "jdjhjdhjhdhjdjhdhj", precscript: "{ 'X' : 12, 'Y' : 20 }", index: "1")
        let createAccountTransaction = TransactionHelper.createAccount(role: .Doctor)
        let createAccountTransaction2 = TransactionHelper.createAccount(role: .Patient)

        var request: URLRequest = URLRequest(url: URL(string: "192.168.1.5:3001/blockchain/transactions")!)
        request.httpBody = createAccountTransaction
        request.httpMethod = HTTPMethod.post.rawValue
        
        AF.request(request).responseJSON { (response) in
            Log.i("Response", file: response)
            switch response.result {
            case .success(let value):
                self.titleLabel.text = "Success"
                self.label.text = "\(value as? [String : Any])"
            case .failure(let error):
                self.titleLabel.text = "Success"
                self.label.text = "\(error)"
            }
            
        }

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


