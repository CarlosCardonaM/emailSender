//
//  ViewController.swift
//  Email Sender
//
//  Created by Carlos Cardona on 14/09/20.
//  Copyright © 2020 Carlos Cardona. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController {
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send an email", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sendButton)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sendButton.frame = CGRect(x: 30, y: 100, width: view.frame.size.width - 60, height: view.frame.size.height - 200)
    }
    
    private func showEmailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            // Show alert to the user
            print("cant be")
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setSubject("Cotización de USUARIO")
        composer.setToRecipients(["charlycardona12@gmail.com"])
        composer.setMessageBody("Buenas tardes, mi nomrbre es USUARIO, Me gustaria una cotizacion pra una REMODELACION de INTERIOR en una HABITACION de PINTURA Y ACABDO. Muchas gracias. USUARIO", isHTML: false)
        
        present(composer, animated: true)
    }
    
    @objc func didTapSendButton() {
        showEmailComposer()
        print("tapped")
    }


}

extension ViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            // Show alert to the user
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("The email has been cancelled")
        case .failed:
            print("The eamil has failed")
        case .saved:
            print("The email has been saved")
        case .sent:
            print("The email has been sent")
        default:
            print("error")
        }
        
        controller.dismiss(animated: true)
    }
    
}

