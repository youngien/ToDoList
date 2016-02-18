//
//  ViewController.swift
//  ToDoList
//
//  Created by David Yu on 2/17/16.
//  Copyright © 2016 David Yu. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tabelView: UITableView!
    
    var tField : UITextField!
    var items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tabelView.dataSource = self
        self.tabelView.delegate = self
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let request = NSFetchRequest(entityName: "Item")
        var results : [AnyObject]?
        
        do {
            results = try context.executeFetchRequest(request)
        } catch _ {
            results = nil
        }
        
        if results != nil{
            self.items = results as! [Item]
        }
        
        
        
        self.tabelView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //
    //    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let item = self.items[indexPath.row]
        cell.textLabel!.text = item.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        didSelectAlertPopup(indexPath)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
        
    }
    
    
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        alertPopup()
    }
    
    func configurationsTextField(textField: UITextField){
        textField.placeholder = "Enter new item."
        self.tField = textField
    }
    
    func saveNewItem(){
        //        print("Item Saved!")
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: context) as! Item
        
        item.title = tField.text
        
        do{
            try context.save()
        } catch _ {
            
        }
        
        let request = NSFetchRequest(entityName: "Item")
        var results : [AnyObject]?
        
        do {
            results = try context.executeFetchRequest(request)
        } catch _ {
            results = nil
        }
        
        if results != nil{
            self.items = results as! [Item]
        }
        
        self.tabelView.reloadData()
        
    }
    
    func alertPopup() {
        
        let alert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default){
            UIAlertAction in
            self.saveNewItem()
            
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        alert.addTextFieldWithConfigurationHandler(configurationsTextField)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func deleteSelectedItem(indexPath: NSIndexPath){
        
        //        print("Item Saved!")
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: context) as! Item
        
        context.deleteObject(items[indexPath.row] as NSManagedObject)
        
        do{
            try context.save()
        } catch _ {
            
        }
        
        let request = NSFetchRequest(entityName: "Item")
        var results : [AnyObject]?
        
        do {
            results = try context.executeFetchRequest(request)
        } catch _ {
            results = nil
        }
        
        if results != nil{
            self.items = results as! [Item]
        }
        
        self.tabelView.reloadData()
        
        
        //self.items.removeAtIndex(indexPath.row)
    }
    
    func didSelectAlertPopup(indexPath: NSIndexPath){
        let alert = UIAlertController(title: "Delete selected Item", message: nil, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.deleteSelectedItem(indexPath)
        }
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        //alert.addTextFieldWithConfigurationHandler(configurationsTextField)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        print("Deleting this! \(self.items[indexPath.row].title)")
    }
}

