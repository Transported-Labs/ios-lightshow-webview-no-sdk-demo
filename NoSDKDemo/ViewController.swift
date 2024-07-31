//
//  ViewController.swift
//  NoSDKDemo
//
//  Created by Alexander Mokrushin on 31.07.2024.
//

import UIKit

class ViewController: UIViewController {

    lazy var webViewController = WebViewController()
    
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func navigateButtonPressed(_ sender: Any) {
        let urlString = self.urlTextField.text ?? ""
        guard urlString != "" else {
            print("Empty URL is not allowed")
            return
        }
        do {
            try webViewController.navigateTo(urlString: urlString)
            webViewController.modalPresentationStyle = .fullScreen
            present(webViewController, animated: true)
        } catch InvalidUrlError.runtimeError(let message){
            self.showToast(message: message, seconds: 2.0)
        } catch {
            self.showToast(message: error.localizedDescription, seconds: 2.0)
        }
    }
    
    @IBAction func openFileButtonPressed(_ sender: Any) {
        let webViewController = WebViewController()
        webViewController.modalPresentationStyle = .fullScreen
        present(webViewController, animated: true) {
            // Navigate to local testing page
            if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
                webViewController.navigateToFile(url: url)
            }
        }
    }
}

extension UIViewController{

    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .systemBackground
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}

