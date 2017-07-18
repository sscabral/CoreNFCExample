//
//  ViewController.swift
//  CoreNFCExample
//
//  Created by Silvio Sousa Cabral on 7/18/17.
//  Copyright © 2017 Silvio Sousa Cabral. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var helper: NFCHelper?
    var payloadLabel: UILabel!
    var payloadText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Apresenta botão para leitura
        let button = UIButton(type: .system)
        button.setTitle("Read NFC", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 28.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(didTapReadNFC), for: .touchUpInside)
        button.frame = CGRect(x: 60, y: 200, width: self.view.bounds.width - 120, height: 80)
        self.view.addSubview(button)
        // Apresenta label para exibir os dados do payload posteriormente
        payloadLabel = UILabel(frame: button.frame.offsetBy(dx: 0, dy: 220))
        payloadLabel.textAlignment = NSTextAlignment.center
        payloadLabel.text = "Press Read to see payload data."
        payloadLabel.numberOfLines = 100
        self.view.addSubview(payloadLabel)
    }
    
    // Executa atualização da UI quando tags são lidas
    func onNFCResult(success: Bool, message: String) {
        if success {
            payloadText = "\(payloadText)\n\(message)"
        }
        else {
            payloadText = "\(payloadText)\n\(message)"
        }
        // Mantém atualização da UI com resultado do scan
        DispatchQueue.main.async {
            self.payloadLabel.text = self.payloadText
        }
        
    }

    // Chamada da classe NFCHelper quando botão de leitura é pressionado
    @objc func didTapReadNFC() {
        if helper == nil {
            helper = NFCHelper()
            helper?.onNFCResult = self.onNFCResult(success:message:)
        }
        payloadText = ""
        helper?.restartSession()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

