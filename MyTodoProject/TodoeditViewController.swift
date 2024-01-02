//
//  TodoeditViewController.swift
//  MyTodoProject
//
//  Created by Apple on 27/09/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class TodoeditViewController: UIViewController {

    @IBOutlet weak var Txttodoid: UITextField!
    @IBOutlet weak var Txttodotitle: UITextField!
    @IBOutlet weak var Txttododetails: UITextField!
    var todoid = ""
    var todotitle = ""
    var tododetails = ""
    
    @IBAction func Btntodoedit(_ sender: Any) {
        API_TodoEdit()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Txttodoid.text = todoid
        self.Txttodotitle.text = todotitle
        self.Txttododetails.text = tododetails
    }
    
    func API_TodoEdit(){
        let url = "https://harshil.in/myapi/crud/todo-edit-api.php"
        
        let param:Parameters = ["todo_id":Txttodoid.text!,
                                "todo_title":Txttodotitle.text!,
                                "todo_details":Txttododetails.text!]
        AF.request(url, method: .post, parameters: param).responseJSON{(response) in
            switch response.result{
            case .success:
                let responseData = JSON(response.data!)
                print(responseData)
                break
            case .failure:
                break
                
            }
        }
    }

}
