//
//  ViewController.swift
//  Simple Note App
//
//  Created by Jinglin Liu on 11/3/17.
//  Copyright © 2017 Jinglin Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var note: Note?
    // var delegate: CellSelectedDelegate?
    
    override func viewDidload(){
        super.viewDidLoad()
        //Do any additional setup after loading the view, typicaly from a nib
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func read(note:Note){
        //read this Note page
        titleLabel.text = note.title
        contentLabel.text = note.contents
        
    }


}

