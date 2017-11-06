//
//  NoteTableViewController.swift
//  Simple Note App
//
//  Created by Jinglin Liu on 11/5/17.
//  Copyright © 2017 Jinglin Liu. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController, UINavigationControllerDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var notes = [NSManagedObjectContext]()
   // var managedObjectContext: NSManagedObjectContext!
    // var delegate: CellSelectedDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: Selector(("addNote")))
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    
    func addNote(){
        let alterController = UIAlertController(title: "Type title", message: "Type Info", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "title", style: UIAlertActionStyle.default, handler: ({{ (<#UIAlertAction#>) in
            <#code#>
            }}))
    }
    
    func saveItem(itemToSave: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext //??
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedObjectContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        
        do {
            try managedObjectContext.save()
            notes.append(item)
        }catch{
            print("Error")
        }
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
    //add botton on table of Notes View
    @IBAction func addNote(_ sender: Any) {
        let noteAdder = Note(context: managedObjectContext)
        noteAdder.title = titleField.text
        noteAdder.contents = contentField.text
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        let _ = navigationController?.popViewController(animated: true)
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
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = titleField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}
