//
//  TodolistTableViewCell.swift
//  MyTodoProject
//
//  Created by Apple on 27/09/23.
//

import UIKit

class TodolistTableViewCell: UITableViewCell {

    @IBOutlet weak var lbltodoid: UILabel!
    @IBOutlet weak var lbltodotitle: UILabel!
    @IBOutlet weak var lbltododetails: UILabel!
    @IBAction func BtnUpdateRecord(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
