import UIKit
import Amani

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cardNumTextField: UITextField!
    @IBOutlet weak var kycBtn: UIButton!

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Initial Setup for UI
    func initialSetup() {
        self.view.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.2352941176, blue: 0.3490196078, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.05882352941, green: 0.1411764706, blue: 0.2078431373, alpha: 1)
        cardNumTextField.inputAccessoryView = setToolBar()
        cardNumTextField.attributedPlaceholder = NSAttributedString(string: "TCK ID Number",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        cardNumTextField.layer.borderWidth = 1
        cardNumTextField.layer.borderColor = UIColor.white.cgColor
        kycBtn.layer.cornerRadius = 10
        kycBtn.clipsToBounds = true
        cardNumTextField.layer.cornerRadius = 10
        cardNumTextField.clipsToBounds = true
        self.dismissKeyboard()
    }

    //MARK: - Submit Button
    @IBAction func go(_ sender: Any) {
        self.view.endEditing(true)
        let customer = CustomerRequestModel(name: "", email: "", phone: "", idCardNumber: cardNumTextField.text ?? "")
        let amaniSDK = AmaniSDK.sharedInstance

        amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer)
        amaniSDK.setDelegate(delegate: self)

        amaniSDK.showSDK(overParent: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func setToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePressOnPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }

    @objc func donePressOnPicker() {
        self.view.endEditing(true)
    }
}

//MARK: - Keyboard dismiss functionality
extension UIViewController {
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.keyboardDismiss))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
}
extension ViewController:AmaniSDKDelegate {
    func onKYCSuccess(CustomerId: Int) {
        
    }
    
    func onKYCFailed(CustomerId: Int, Rules: [[String : String]]?) {
        
    }
    
    func onTokenExpired() {
        
    }
    
    
}
