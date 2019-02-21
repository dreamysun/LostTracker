//
//  MyTableViewController.swift
//  table2
//
//  Created by Dreamy Sun on 2/18/19.
//  Copyright © 2019 ChenyuSun. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TableViewCell"

private let elementArrayKey = "ELEMENT_ARRAY_KEY"


struct Element: Codable {
    var date: String
    var message: String
    var imageURL: URL?
}

class MyTableViewController: UITableViewController {
    
     var elementArray = [Element]()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView!.backgroundColor = UIColor(red: 0xf0/255, green: 0xf0/255,
                                                  blue: 0xf0/255, alpha: 1)
        self.tableView!.separatorStyle = .none
        self.navigationController?.navigationBar.titleTextAttributes =
            [.foregroundColor: UIColor.gray]
        
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        
        
        self.view.layer.contents = UIImage(named:"water2.jpg")!.cgImage
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
       // print ("did load")
        if let data = UserDefaults.standard.value(forKey: elementArrayKey) as? Data {
            
            let elementArray = try? PropertyListDecoder().decode(Array<Element>.self, from: data)
            
            self.elementArray = elementArray!
            
            self.tableView.reloadData()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func writeAdd(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MyViewController") as? MyViewController else {
            print("Error instantiating ActionViewController" )
            return
        }
                vc.didSaveElement = { [weak self] element in
                    
                    self?.elementArray.append(element)
                    
                    // Resave element array into User defaults.
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(self?.elementArray), forKey: elementArrayKey)
                    
                    self?.tableView.reloadData()
            }
            
            // Present view controller.
            present(vc, animated: true, completion: nil)
            
    
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let _:CGFloat = 15.0
        
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: reuseIdentifier)
            as! TableViewCell
        cell.accessoryType = .disclosureIndicator
        _ = CAShapeLayer()
        cell.layer.mask = nil
        
        cell.layer.cornerRadius = 8
        
        return elementArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCell
        
        let element = elementArray[indexPath.row]
    
//        print(element.date)
//        print(element.message)
//        print(element.imageURL)

        cell.text1.text = element.date
        cell.text2.text = element.message
        cell.layer.cornerRadius = 8
        

        do {

            let data = try Data(contentsOf: element.imageURL!)
            let imageFromDeviceMemory = UIImage(data: data)
            
            cell.pic1.image = imageFromDeviceMemory
            cell.pic1.layer.masksToBounds = true;
            cell.pic1.layer.cornerRadius = 10
            
            
        } catch {
            print(error)
        }
        


         //Configure the cell...

        return cell
    }
}



    
    
    class TableViewCell: UITableViewCell{
        
        override var frame: CGRect {
            get {
                return super.frame
            }
            set {
                var frame = newValue
                frame.origin.x += 15
                frame.size.width -= 2 * 15
                frame.origin.y += 15
                frame.size.height -= 2 * 15
                super.frame = frame
            }
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
            pic1.layer.cornerRadius = 8
            view.layer.cornerRadius = 8
            
        }
        
        
        @IBOutlet weak var viewCell: UITableViewCell!
        @IBOutlet weak var view: UITableViewCell!
        @IBOutlet weak var text1: UILabel!
        @IBOutlet weak var pic1: UIImageView!
        @IBOutlet weak var text2: UILabel!
        
        
        
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


