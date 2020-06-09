//
//  ViewController.swift
//  BlockHeal
//
//  Created by ali on 5/19/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import UIKit
import SawtoothSigning

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let x = TransactionHelper.sendPrescript(recieverPublicKeyHex: TransactionHelper.publicKey.hex(), precscript: "{ 'X' : 12, 'Y' : 20 }")
        //        if TransactionHelper.publicKey == nil {
        //            let context = Secp256k1Context()
        ////            KeyChain.save(key: UserDefaultKeys.PrivateKey.rawValue, data: Data(repeating: context.newRandomPrivateKey(), count: 9))
        ////
        //            print(TransactionHelper.privateKey?.hex())
        //
        //
        //        } else {
        //            print(TransactionHelper.privateKey?.hex())
        //        }
    }
}


