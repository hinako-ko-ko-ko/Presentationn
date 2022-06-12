//
//  ListTableViewController.swift
//  presentation
//
//  Created by 中井日向子 on 2022/05/22.
//

import UIKit

class ListTableViewController: UITableViewController{
    var detailArray = [[String]]()//配列
        
       
    var indexNum = 0 //セルの番号を記憶しておく変数
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
        detailArray = UserDefaults.standard.object(forKey: "detail") as! [[String]]//取得
       
            
            tableView.reloadData()
        }


    // MARK: - Table view data source
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return detailArray.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                as! ListTableViewCell
            
            
            
            
            cell.titlelabel.text = detailArray[indexPath.row][0]//表示
            cell.targettimelabel.text = detailArray[indexPath.row][1]//表示
            cell.timerlabel.text = detailArray[indexPath.row][3]//表示
            cell.manuscriptlabel.text = detailArray[indexPath.row][2]//表示
          print(detailArray)
            
            
            return cell
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) //セルをタップしたときに走るコード
    {
            
        tableView.deselectRow(at: indexPath, animated: true)
            indexNum = indexPath.row //作成しておいた変数にタップした時のセルの番号を代入
        performSegue(withIdentifier: "showDetailSegue", sender: nil) //segue
           
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "showDetailSegue") {
            let nextVC: DetailViewController = (segue.destination as? DetailViewController)!//次のビューコントローラーに値を渡すことができる
            
            nextVC.num = indexNum //変数に次のビューコントローラーのセグエを代入
        }
    }
}
    


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        // Configure the cell...
        return cell
    }
    */

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

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */




