//
//  DoneViewController.swift
//  QRCodeReader
//
//  Created by eno o udo jr on 5/3/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class DoneViewController: UIViewController {
var products: String!
    
    struct Product: Codable {
        
        let upcnumber: String?
        
        let title: String?
        let alias: String?
        let description: String?
        let brand: String?
        let msrp: String?
        let status: Int?
        enum CodingKeys: String, CodingKey {
            case upcnumber
            case title
            case alias
            case description
            case brand
            case msrp
            case status
        }
        
        
        
    }
    var upc : String!
    var tit: String!
    var msrp: String!
    @IBOutlet weak var viewText: UITextView!
    @IBOutlet weak var txt: UILabel!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        txt.text="Loading"
        guard let url = URL(string: "https://api.upcdatabase.org/product/\(products!)/E20EF0208D99D07BE82863E3CC492B2C") else {return}
        URLSession.shared.dataTask(with: url) { (data, response //async task
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                 let prodData = try decoder.decode(Product.self, from: data)
                DispatchQueue.main.sync {//async , main thread can update here
                    print(prodData)
                //update text
                    
                        self.upc = prodData.upcnumber
                        self.msrp = prodData.msrp
                        self.tit = prodData.title
                    
                    if self.upc != nil{
                        self.txt.text=""
                        self.viewText.insertText("upc: \(self.upc!)\n" +
                            "title: \(self.tit!)\n" +
                            "msrp: $\(self.msrp!)")
                    }else{
                        self.txt.text="not found in DB: \(self.products)"
                    }
                    
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
        
        //txt.text = products!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
