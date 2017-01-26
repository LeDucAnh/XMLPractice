//
//  ViewController.swift
//  XMLPractice
//
//  Created by Mac on 1/20/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit
import Fuzi
class ViewController: UIViewController {

    func readFormXMLFile()
    {
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let file = "BaiTap_2" //this is the file. we will write to and read from it
        
        
        
        
        let path = Bundle.main.path(forResource: "BaiTap_2", ofType: "xml")
        
        do
        {
            var xml = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            
            print(xml)
            
            do {
                // if encoding is omitted, it defaults to NSUTF8StringEncoding
                let document = try XMLDocument(string: xml, encoding: String.Encoding.utf8)
                
                //element
                for element in document.xpath("//customer") {
                    print("\(element.tag): \(element.attributes)")
                    //  print(element.stringValue)
                    print("Email")
                    
                    print(element.document.xpath("//emailCus").first?.stringValue)
                    
                }
                
                
                if let root = document.root {
                    print(root.tag)
                    // iterate through all children
                    for element in root.children {
                        print("\(index) \(element.tag): \(element.attributes)")
                        //  print(element.numberValue)
                        print(element.stringValue)
                        
                    }
                    
                }
                // you can also use CSS selector against XMLDocument when you feels it makes sense
            } catch let error as XMLError {
                switch error {
                case .noError: print("wth this should not appear")
                case .parserFailure, .invalidData: print(error)
                case .libXMLError(let code, let message):
                    print("libxml error code: \(code), message: \(message)")
                }
            }
            
            
        }
        catch{
            
        }
        
        
        
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readFormXMLFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

