//
//  ViewController.swift
//  XMLPractice
//
//  Created by Mac on 1/20/17.
//  Copyright © 2017 LeDucAnh. All rights reserved.
//

import UIKit
import Fuzi
class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var OrderArray = [XMLPOrder]()
    func readFormXMLFile()
    {
        
        // Do any additional setup after loading the view, typically from a nib.
        //read form xml file 
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
                    
                   
                    
                }
                for element in document.xpath("//orderList/order") {

                    let order = XMLPOrder(xmlDoc: element)
                    self.OrderArray.append(order)

                
                }
                if let root = document.root {
                    print(root.tag)
                    // iterate through all children
                    for element in root.children {
 
                        
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
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource =  self
        tableView.delegate =  self
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     tableView.deselectRow(at: indexPath, animated: true)

        let alert = UIAlertController(title: "Alert", message: self.OrderArray[indexPath.row].reportString(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return OrderArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        var TitleString = "#Order " + String(indexPath.row + 1) + " "
        
        let attString = NSMutableAttributedString(string: "")
        attString.append(NSMutableAttributedString(string: TitleString, attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 17.0),NSForegroundColorAttributeName:UIColor.brown]))
        
        TitleString = "by " + " @" + String(self.OrderArray[indexPath.row].firstName) + String(self.OrderArray[indexPath.row].lastName)
        attString.append(NSMutableAttributedString(string: TitleString, attributes: [NSForegroundColorAttributeName:UIColor.gray]))
        

        
        cell?.textLabel?.attributedText = attString
        
  //    cell?.textLabel?.text =   self.OrderArray[indexPath.row].firstName +   String(self.OrderArray[indexPath.row].calcuateTotalPrice())
        return  cell!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

