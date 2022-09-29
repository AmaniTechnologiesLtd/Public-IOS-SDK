import UIKit
import Amani

class ViewController: UIViewController, UITextFieldDelegate {
    var country: String?
    @IBOutlet weak var cardNumTextField: UITextField!
    @IBOutlet weak var kycBtn: UIButton!
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var countrySelectButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
  
    let backgroundColor:UIColor = #colorLiteral(red: 0.1450980392, green: 0.2352941176, blue: 0.3490196078, alpha: 1)
    let foregroundColor:UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  
    let countryTitles = [
      "Russia",
      "Ukraine",
      "Indonesia",
      "Azerbaijan",
      "Saudi Arabia",
      "Kyrgyzstan",
      "Kazakhstan",
      "Egypt",
      "Peru",
      "Mexico",
      "Morocco",
      "Belarus",
      "Ecuador",
      "Oman",
      "Thailand",
      "Iraq",
      "Paraguay",
      "Uzbekistan",
      "Bahrain",
      "India",
      "Turkey"
    ]
  
    let countryCodes = [
        "RUS",
        "UKR",
        "IDN",
        "AZE",
        "SAU",
        "KGZ",
        "KAZ",
        "EGY",
        "PER",
        "MEX",
        "MAR",
        "BLR",
        "ECU",
        "OMN",
        "THA",
        "IRQ",
        "PRY",
        "UZB",
        "BHR",
        "IND",
        "TUR",
    ]
  
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
        self.view.backgroundColor = backgroundColor
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.05882352941, green: 0.1411764706, blue: 0.2078431373, alpha: 1)
        cardNumTextField.inputAccessoryView = setToolBar()
        cardNumTextField.attributedPlaceholder = NSAttributedString(string: "TCK ID Number",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        cardNumTextField.layer.borderWidth = 1
        cardNumTextField.layer.borderColor = UIColor.white.cgColor
        kycBtn.layer.cornerRadius = 10
        kycBtn.clipsToBounds = true
        kycBtn.isEnabled = false
        countrySelectButton.layer.cornerRadius = 10
        countrySelectButton.clipsToBounds = true
        cardNumTextField.layer.cornerRadius = 10
        cardNumTextField.clipsToBounds = true
        self.dismissKeyboard()
        
        // MARK: - Country Picker Setup
        countryPicker.isHidden = true
        doneButton.isHidden = true
        countryPicker.dataSource = self
        countryPicker.delegate = self
    }

    //MARK: - Submit Button
    @IBAction func go(_ sender: Any) {
        self.view.endEditing(true)
        let customer = CustomerRequestModel(name: "", email: "", phone: "", idCardNumber: cardNumTextField.text ?? "")
        if #available(iOS 11, *) {
            let amaniSDK = AmaniSDK.sharedInstance
 
          // country selection
          amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer, useGeoLocation: false, language: "tr", country: country)
            /*
             if dont want to use location permissions please provide with useGeoLocation parameter
             amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,useGeoLocation: false)

             select showing language with language parameter
             amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,language: "tr")
             
             
             amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,useGeoLocation: false,language: "tr")
             
             for use nfcOnly option you need to provide nviData
         
             let nviData = NviModel(documentNo: "DocumentNo", dateOfBirth: "YYMMDD", dateOfExpire: "YYMMDD")
             amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,nvi:nvidata)
             */
        amaniSDK.setDelegate(delegate: self)

        amaniSDK.showSDK(overParent: self)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func setToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .blue
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePressOnPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }

    @objc func donePressOnPicker() {
        self.view.endEditing(true)
        go(self)
    }
  
   //MARK: - Select Country Button
  @IBAction func selectCountry(_ sender: Any) {
    countryPicker.isHidden.toggle()
    doneButton.isHidden.toggle()
    countrySelectButton.isEnabled.toggle()
  }
  
  
  @IBAction func donePressed() {
    countryPicker.isHidden.toggle()
    countrySelectButton.isEnabled.toggle()
    doneButton.isHidden.toggle()
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
    
    func onEvent(name: String, Parameters: [String]?, type: String) {
        
    }
    
    func onConnectionError(error: String?) {
        
    }
    
    func onNoInternetConnection() {
        
    }
    
    func onKYCSuccess(CustomerId: Int) {
        
    }
    
    func onKYCFailed(CustomerId: Int, Rules: [[String : String]]?) {
        
    }
    
    func onTokenExpired() {
        
    }
    
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return countryTitles.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return countryTitles[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    country = countryCodes[row]
    kycBtn.isEnabled = true
    countrySelectButton.setTitle("Selected Country \(countryTitles[row])", for: .normal)
  }
  
  
}
