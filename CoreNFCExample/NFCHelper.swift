//
//  NFCHelper.swift
//  CoreNFCExample
//
//  Created by Silvio Sousa Cabral on 7/18/17.
//  Copyright © 2017 Silvio Sousa Cabral. All rights reserved.
//

import Foundation
import CoreNFC

class NFCHelper: NSObject, NFCNDEFReaderSessionDelegate {
    var onNFCResult: ((Bool, String) -> ())?
    
    //Reinicia sessão após scan
    func restartSession() {
        let session =
            NFCNDEFReaderSession(delegate: self as NFCNDEFReaderSessionDelegate,
                                 queue: nil,
                                 invalidateAfterFirstRead: true)
        session.begin()
    }
    
    // MARK: NFCNDEFReaderSessionDelegate
    // Métodos obrigatórios
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error){
        guard let onNFCResult = onNFCResult else {
            return
        }
        onNFCResult(false, error.localizedDescription)
    }
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]){
        print("Did detect NDEFs.")
        //Loop pelos registros encontrados na tag
        for message in messages {
            for record in message.records {
                print(record.identifier)
                print(record.payload)
                print(record.type)
                print(record.typeNameFormat)
                print()
            }
        }
    }
}
