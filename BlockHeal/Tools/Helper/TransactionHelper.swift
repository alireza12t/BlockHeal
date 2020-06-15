//
//  TransactionHelper.swift
//  BlockHeal
//
//  Created by ali on 6/8/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import Foundation
import os
import CommonCrypto
import SawtoothSigning
import SwiftProtobuf
import SwiftyJSON
import SwiftCBOR

enum UserDefaultKeys:String {
    case Token
    case IsFaceIdEnabled
    case PrivateKey
    case PublicKey
}

enum Role: String{
    case Doctor
    case Patient
    case DrugStore
}


class TransactionHelper {
    
    static var context: Secp256k1Context = Secp256k1Context()
    
    class func getSigner() -> Signer{
        return Signer(context: context, privateKey: privateKey)
    }
    
    class func hash(data: Data) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
            let value = data as NSData
            CC_SHA512(value.bytes, CC_LONG(data.count), &digest)
        
        let digestHex = digest.map { String(format: "%02hhx", $0) }.joined()
        return digestHex
    }
    
    class func hash(item: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        if let data = item.data(using: String.Encoding.utf8) {
            let value = data as NSData
            CC_SHA512(value.bytes, CC_LONG(data.count), &digest)
        }
        let digestHex = digest.map { String(format: "%02hhx", $0) }.joined()
        return digestHex
    }
    
    
    class func sendPrescript(recieverPublicKeyHex: String, precscript: String, index: String) -> Data? {
        let signer: Signer!
        signer = getSigner()
        
        var recievePrescript = SendPrescriptAction()
        recievePrescript.patPublicKey = publicKey.hex()
        recievePrescript.docPublicKey = recieverPublicKeyHex
        recievePrescript.hash = hash(item: index + publicKey.hex() + recieverPublicKeyHex + precscript)
        
        let encodedPrescript = try? CBOR.encodeAny(recievePrescript)
        
        if let payload = encodedPrescript {
            return createTxn(encodedPayload: payload, signer: signer)
        }
        return nil
    }
    
    class func createAccount(role: Role) -> Data? {
        let signer: Signer!
        signer = getSigner()
        
        var createAccount = CreateAccountAction()
        createAccount.label = role.rawValue
        
        let encodedCreateAccount = createAccount.encode()
        
        return createTxn(encodedPayload: encodedCreateAccount, signer: signer)
        
    }
    

    

    
    class func createTxn(encodedPayload: [UInt8], signer: Signer) -> Data? {
        //MARK: Create the Transaction Header
        do {
            var transactionHeader = TransactionHeader()
            transactionHeader.signerPublicKey = try signer.getPublicKey().hex()
            transactionHeader.batcherPublicKey = try signer.getPublicKey().hex()
            
            transactionHeader.familyName = "BlockHeal"
            transactionHeader.familyVersion = "1.0"
            transactionHeader.inputs = ["'59b423'"]
            transactionHeader.outputs = ["'59b423'"]
            
            transactionHeader.payloadSha512 = TransactionHelper.hash(data: Data(bytes: encodedPayload, count: encodedPayload.encode().count))
            transactionHeader.nonce = UUID().uuidString
            
            
            //MARK: Create the Transaction
            var transaction = Transaction()
            do {
                let transactionHeaderData = try transactionHeader.serializedData()
                transaction.header = transactionHeaderData
                let signatureData = transactionHeaderData.map {UInt8 (littleEndian: $0)}
                do {
                    let signature = try signer.sign(data: signatureData)
                    transaction.headerSignature = signature
                } catch {
                    Log.e("Unexpected error signing batch ")
                }
            } catch {
                Log.e("Unable to serialize data")
            }
            transaction.payload = Data(bytes: encodedPayload, count: encodedPayload.encode().count)
            
            
            //MARK: Encode the Transaction(s)
            do {
                let txn_bytes = try transaction.serializedData()
                return txn_bytes
                
//                //MARK: Create the BatchHeader
//
//                var batchHeader = BatchHeader()
//                do {
//                    batchHeader.signerPublicKey = try signer.getPublicKey().hex()
//                } catch {
//                    Log.e("Failed to get signer public key")
//                }
//                batchHeader.transactionIds = [transaction.headerSignature]
//
//                //MARK: Create the Batch
//
//                var batch = Batch()
//                do {
//                    let batchHeaderData = try batchHeader.serializedData()
//                    batch.header = batchHeaderData
//                    let signatureData = batchHeaderData.map {UInt8 (littleEndian: $0)}
//                    do {
//                        let signature = try signer.sign(data: signatureData)
//                        batch.headerSignature = signature
//                    } catch {
//                        Log.e("Unexpected error signing batch")
//                    }
//                } catch {
//                    Log.e("Unable to serialize data")
//                }
//                batch.transactions = [transaction]
//
//
//                //MARK: Encode the Batch(es) in a BatchList
//                var batchList = BatchList()
//                batchList.batches = [batch]
//                do {
//                    let batchList_data = try batchList.serializedData()
//                    return batchList_data
//                } catch {
//                    Log.e("Unable to serialize data")
//                }
            } catch {
                Log.e("Unable to serialize data")
            }
            
        } catch {
            Log.e("failed to Create transactionHeader \(error)")
        }
        return nil
    }
    
    
    static var publicKey: PublicKey {
        get{
            return try! context.getPublicKey(privateKey: TransactionHelper.privateKey)
        }
        set (newValue) {
            UserDefaults.standard.setValue(newValue.hex(), forKey: UserDefaultKeys.PublicKey.rawValue)
        }
    }
    
    static var privateKey: PrivateKey {
        get{
            let privateKeyHex = UserDefaults.standard.string(forKey: UserDefaultKeys.PrivateKey.rawValue) ?? context.newRandomPrivateKey().hex()
            return Secp256k1PrivateKey.fromHex(hexPrivKey: privateKeyHex)
        }
        set (newValue) {
            UserDefaults.standard.setValue(newValue.hex(), forKey: UserDefaultKeys.PrivateKey.rawValue)
        }
    }
    
}



class StoringData {
    
    static var isFaceIdEnabled:Bool {
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultKeys.IsFaceIdEnabled.rawValue)
        }
        set (newValue) {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.IsFaceIdEnabled.rawValue)
        }
    }
    
    static var token: String {
        get{
            return UserDefaults.standard.string(forKey: UserDefaultKeys.Token.rawValue) ?? ""
        }
        set (newValue) {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.Token.rawValue)
        }
    }
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
