//
//  ViewController.swift
//  MyTodoProject
//
//  Created by Apple on 26/09/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage


class ViewController: UIViewController {
    
    @IBOutlet weak var TodoTitle: UITextField!
    @IBOutlet weak var TodoDetails: UITextField!
    
    @IBAction func TodoAdd(_ sender: Any) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "TodoListViewController") as! TodoListViewController
        if validate{
            TodoAdd()
        }
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func TodoViewList(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(identifier: "TodoListViewController") as! TodoListViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var validate:Bool{
        if TodoTitle.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            let alert = UIAlertController(title: "Message", message: " Please Enter Title", preferredStyle: .actionSheet)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert,animated: true,completion: nil)
            return false
        }
        
        if TodoDetails.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            let alert = UIAlertController(title: "Message", message: "Please Enter Detail", preferredStyle: .actionSheet)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert,animated: true,completion: nil)
            return false
        }
       return true
    }
    
        
        func TodoAdd(){
            let url = "https://harshil.in/myapi/crud/todo-add-api.php"
            
            let param:Parameters = ["todo_title":TodoTitle.text!,
                                    "todo_details":TodoDetails.text!]
            AF.request(url, method: .post, parameters: param).responseJSON{(response) in
                switch response.result{
                case .success:
                    let responseData = JSON(response.data! )
                    print(responseData)
                    let flag = responseData["flag"].stringValue
                                    let message = responseData["message"].stringValue
                                   if flag == "1"{
                                        let alert = UIAlertController(title: "message", message: message, preferredStyle: .alert)
                                        let ok = UIAlertAction(title: "ok", style: .default , handler: nil)
                                        alert.addAction(ok)
                                        self.present(alert,animated: true,completion: nil)
                                        
                                    }else{
                                        let alert = UIAlertController(title: "message", message: message, preferredStyle: .alert)
                                        let ok = UIAlertAction(title: "ok", style: .default , handler: nil)
                                        alert.addAction(ok)
                                        self.present(alert,animated: true,completion: nil)
                                    }
                    break
                case .failure:
                    break
                    
                }
                //self.TodoAdd()
            }
        }
    }

