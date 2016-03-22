//
//  TaskDetailsController.swift
//  TaskList
//
//  Created by Speros Misirlakis on 2/25/16.
//  Copyright © 2016 Speros Misirlakis. All rights reserved.
//

import Foundation
import UIKit // ADD

class TaskDetailsController: UIViewController {

//    var delegate: ViewController?
    var delegate: GoBackProtocol?
    
//    var task: UITableViewCell?
    var task: Task?

    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
        delegate?.goBack()
    }
    
    
    
    @IBOutlet weak var testPicker: UIPickerView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Here: ", task)
        print(task?.title)
        print(task?.details)
      }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
}