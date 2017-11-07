//
//  NoteTableViewController.swift
//  Simple Note App
//
//  Created by Jinglin Liu on 11/5/17.
//  Copyright © 2017 Jinglin Liu. All rights reserved.
//

import UIKit
import CoreData
import os.log

class NoteTableViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var notes = [Note]()
    var managedObjectContext: NSManagedObjectContext!
    // var delegate: CellSelectedDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadData()
    }
    
    func loadData(){
        let noteRequest:NSFetchRequest<Note> = Note.fetchRequest()
        
        do{
            notes = try managedObjectContext.fetch(noteRequest)
            self.tableView.reloadData()
        }catch {
            print("Error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NoteTableViewCell
        
        let currentNote = notes[indexPath.row]
    
        cell.titleLabel.text = currentNote.title
        
        return cell
    }
    @IBAction func cancel(_ sender: Any) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddNote = presentingViewController is UINavigationController
        
        if isPresentingInAddNote {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The NoteTableViewController is not inside a navigation controller.")
        }
    }
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
    
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
            let noteAdder = Note(context: managedObjectContext)
            
            noteAdder.title = titleField.text
            noteAdder.contents = contentField.text
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            let _ = navigationController?.popViewController(animated: true)
        }
    
    func createNoteItem(){
        let noteAdder = Note(context: managedObjectContext)
        let alertController = UIAlertController(title: "Type title", message: "Type Info", preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "title"
        }
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "contents"
        }
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action:UIAlertAction) in
            let titleField = alertController.textFields?.first
            let contentField = alertController.textFields?.last
            
            if titleField?.text != "" && contentField?.text != ""{
                noteAdder.title = titleField?.text
                noteAdder.contents = contentField?.text
                
                do{
                    try self.managedObjectContext.save()
                }catch{
                    print("error")
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        managedContext.delete(notes[indexPath.row])
        
}
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = titleField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
