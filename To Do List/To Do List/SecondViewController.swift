//
//  SecondViewController.swift
//  To Do List
//
//  Created by Claudio Tezzin Jeremias on 03/09/17.
//  Copyright © 2017 Claudio Tezzin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textView: UITextField!
    
    @IBAction func Add(_ sender: Any) {
        var list = [String]()
        
        if let templist = UserDefaults.standard.object(forKey: "to_do_list") as? [String] {
            if let text = textView.text {
                list = templist
                list.append(text)
            }
            else {
                list = [textView.text!]
            }
        }
        
        UserDefaults.standard.set(list, forKey: "to_do_list")
        textView.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

