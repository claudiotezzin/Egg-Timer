//
//  ViewController.swift
//  Wheater App
//
//  Created by Claudio Tezzin Jeremias on 05/09/17.
//  Copyright © 2017 Claudio Tezzin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func submit(_ sender: Any) {
        let formattedUrlString = "http://www.weather-forecast.com/locations/" +
            textField.text!.replacingOccurrences(of: " ", with: "-") +
        "/forecasts/latest"
        
        if let url = URL(string: formattedUrlString) {
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.resultLabel.text = "The weathe of your city was not found! Please try again"
                    }
                } else {
                    self.parseAndPresentWheater(data: data!)
                }
            }
            
            task.resume()
        }
        else {
            self.resultLabel.text = "The weathe of your city was not found! Please try again"
        }
    }
    
    private func parseAndPresentWheater(data: Data) {
        var message = "The weathe of your city was not found! Please try again"
        let dataStr = String(data: data, encoding: String.Encoding.utf8)
        var separator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
        
        
        if let contentArray = dataStr?.components(separatedBy: separator) {
            if contentArray.count > 2 {
                separator = "</span>"
                let newContentArray = contentArray[1].components(separatedBy: separator)
                if newContentArray.count > 1 {
                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                    print(message)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.resultLabel.text = message
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

