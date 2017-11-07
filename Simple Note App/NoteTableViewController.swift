//
//  NoteTableViewController.swift
//  Simple Note App
//
//  Created by Jinglin Liu on 11/5/17.
//  Copyright © 2017 Jinglin Liu. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController{

    var note = [Note](){
        didSet{
            tableView.reloadData()
        }
    }
    
    // var delegate: CellSelectedDelegate?

    override func viewDidLoad() {

        super.viewDidLoad()
        note = CoreDataFile.retrieveNote()   
    }
    /*
    func loadData(){
        let noteRequest:NSFetchRequest<Note> = Note.fetchRequest()
        
        do{
            note = try managedObjectContext.fetch(noteRequest)
            self.tableView.reloadData()
        }catch {
            print("Error")
        }
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
   /* override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return note.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NoteTableViewCell
        
        let currentNote = note[indexPath.row]
    
        cell.titleLabel.text = currentNote.title
        
        return cell
    }
    

    @IBAction func backToNoteTVC(_ segue: UIStoryboardSegue) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            CoreDataFile.deleteNote(note: note[indexPath.row])
            note = CoreDataFile.retrieveNote()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let id = segue.identifier{
            if id == "showDetail" {
                print("tapped")
                let indexPath = tableView.indexPathForSelectedRow!
                let selectedCell = note[indexPath.row]
                
                let displayNoteVC = segue.destination as! NoteViewController
                displayNoteVC.note = selectedCell
                
            }else if id == "addNote"{
                print("add")
            }
        }
    }
}
