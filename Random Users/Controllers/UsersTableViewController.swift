//
//  UsersTableViewController.swift
//  Random Users
//
//  Created by William Chen on 10/4/19.
//  Copyright © 2019 Erica Sadun. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    var users: Results?{
        didSet{
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
    var userController = UserController()
    
    var key = Cache<String, UIImage>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userController.fetchUsersPhotos { (usersList, error) in
            if let error = error{
                NSLog("There is an \(error)")
                return
            }
            self.users = usersList ?? self.users
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
            
        }
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users?.results.count ?? 0
    }
    
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
       
        let user = users?.results[indexPath.row]

        //cell.textLabel?.text = user.name
    if let URL = user?.picture {

            if key.value(key: "\(URL)") != nil {
                cell.imageView?.image = key.value(key: "\(URL)")
            }else{
                let urlSession = URLRequest(url: URL)
                URLSession.shared.dataTask(with: urlSession){(data, _, error) in
                    if let error = error {
                        NSLog("This is an \(error)")
                        return
                    }
                    guard let data = data else {return}
                    print(data)

                    DispatchQueue.main.async {
                        guard let image = UIImage(data: data) else {return}
                        cell.imageView?.image = image
                        self.key.cache(value: image, key: "\(URL)")
                    }
                }.resume()
            }

        }

        cell.textLabel?.text = user?.name
//        // Configure the cell...
//
        return cell
    }
//
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
//
//    private func loadCellInfo(forCell cell: UITableViewCell, forItemAt indexPath: IndexPath) {
//        let user = users?.results[indexPath.row]
//
//        cell.textLabel?.text = user?.name
//
//        if let image = cache.fetch(key: "\(user.picture.thumbnail)") {
//            cell.imageView?.image = image
//            return
//        }
//
//        guard let imageURL = URL(string: user.picture.large) else { return }
//        let imageRequest = URLRequest(url: imageURL)
//
//        URLSession.shared.dataTask(with: imageRequest) { (data, _, error) in
//            if let error = error {
//                NSLog("Error fetching image data: \(error)")
//                return
//            }
//
//            guard let data = data else {
//                NSLog("Error. No data returned from given URL")
//                return
//            }
//
//            DispatchQueue.main.async {
//                let image = UIImage(data: data)
//                cell.imageView?.image = image
//
//                if let image = image {
//                    self.cache.imageDict["\(user.picture.thumbnail)"] = image
//                }
//            }
//        }.resume()
//    }
//    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let detailVC = segue.destination as? UserDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            
            detailVC.key = key
            detailVC.user = users?.results[indexPath.row]
        } 
    }
    
    
}
