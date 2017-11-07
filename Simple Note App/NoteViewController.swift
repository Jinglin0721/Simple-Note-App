//
//  NoteViewController.swift
//  Simple Note App
//
//  Created by Jinglin Liu on 11/7/17.
//  Copyright © 2017 Jinglin Liu. All rights reserved.
//

import UIKit


class NoteViewController: UIViewController {

    //properties:
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = note{
            navigationItem.title = note.title
            titleField.text = note.title
            contentField.text = note.contents
        } else{
            titleField.text = ""
            contentField.text = ""
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "save"{
            let note = self.note ?? CoreDataFile.crateNote()
            note.contents = contentField.text ?? ""
            note.title = titleField.text ?? ""
            CoreDataFile.saveNote()
        }
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
