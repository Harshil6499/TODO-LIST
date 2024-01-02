//
//  TodoListViewController.swift
//  MyTodoProject
//
//  Created by Apple on 26/09/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class TodoListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_todo_title.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! TodolistTableViewCell
        cell.lbltodoid.text = arr_todo_id[indexPath.row]
        cell.lbltodotitle.text = arr_todo_title[indexPath.row]
        cell.lbltododetails.text = arr_todo_details[indexPath.row]
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let deleteaction = UIAlertController(title: "Todo Details", message: "Would You Like To Delete Your Data...?", preferredStyle: .actionSheet)
            let Delete = UIAlertAction(title: "Delete", style: .default)
            
            { (alert) in
                self.API_TodoDelete(todo_id: self.arr_todo_id[indexPath.row])
                
                let simpleaction = UIAlertController(title: "Delete", message: "Record Deleted", preferredStyle: .actionSheet)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                simpleaction.addAction(ok)
                self.present(simpleaction,animated: true ,completion: nil)
            }
            let Cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            deleteaction.addAction(Delete)
            deleteaction.addAction(Cancel)
            self.present(deleteaction,animated: true,completion: nil)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = storyboard?.instantiateViewController(identifier: "DatadisplayViewController") as! DatadisplayViewController
            main.todo_id = arr_todo_id[indexPath.row]
           main.todo_title = arr_todo_title[indexPath.row]
           main.todo_details = arr_todo_details[indexPath.row]

        self.navigationController?.pushViewController(main, animated: true)
    }

    @IBAction func Edit(_ sender: Any) {
        let home = storyboard?.instantiateViewController(identifier: "TodoeditViewController") as! TodoeditViewController
          home.todoid = arr_todo_id[0]
          home.todotitle = arr_todo_title[0]
          home.tododetails = arr_todo_details[0]
          print(arr_todo_id)
          print(arr_todo_title)
          print(arr_todo_details)
          self.navigationController?.pushViewController(home, animated: true)
        
    }
    
    var arr_todo_id = [String]()
    var arr_todo_title = [String]()
    var arr_todo_details = [String]()
    @IBOutlet weak var TodolistTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API_TodoList()
        self.TodolistTableView.dataSource = self
        self.TodolistTableView.delegate = self

    }
    
    func API_TodoList(){
        let url = "https://harshil.in/myapi/crud/todo-list-api.php"
        AF.request(url).responseJSON{(response) in
            switch response.result{
            case .success:
                let myresult = try? JSON(data: response.data!)
                print(response.result)
                
                let resultArray = myresult!["todo_list"]
                self.arr_todo_id.removeAll()
                self.arr_todo_title.removeAll()
                self.arr_todo_details.removeAll()
                
                for i in resultArray.arrayValue{
                    let todo_id = i["todo_id"].stringValue
                    self.arr_todo_id.append(todo_id)
                    
                    let todo_title = i["todo_title"].stringValue
                    self.arr_todo_title.append(todo_title)
                    
                    let todo_details = i["todo_details"].stringValue
                    self.arr_todo_details.append(todo_details)
                    print(todo_id)
                    print(todo_title)
                    print(todo_details)
                }
                
                self.TodolistTableView.reloadData()
                break
                
            case .failure:
                break
            }
        }
    }
    func API_TodoDelete(todo_id:String){
        let url = "https://harshil.in/myapi/crud/todo-delete-api.php"
        let param:Parameters = ["todo_id":todo_id]
        AF.request(url, method: .post,parameters: param).responseJSON{(response) in
            switch response.result{
            case .success:
                let responseData = JSON(response.data!)
                print(responseData)
                break
            case .failure:
                break
                
            }
            
        }
        API_TodoList()
        
        
    }

}
/*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if(editingStyle == .delete){
        
        var validate:Bool{
            if API_TodoDelete.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                let alert = UIAlertController(title: "Message", message: " Please Enter Title", preferredStyle: .actionSheet)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert,animated: true,completion: nil)
                return false
            }
            return true
        }
        self.API_TodoDelete(todo_id: arr_todo_id[indexPath.row])
    }
}*/
