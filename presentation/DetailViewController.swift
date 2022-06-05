//
//  DetailViewController.swift
//  presentation
//
//  Created by 中井日向子 on 2022/06/03.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var titlelabel: UILabel!
    var detailArray: [Dictionary<String,String>] = []
        
        let saveData = UserDefaults.standard

   

    override func viewDidLoad() {
        super.viewDidLoad()
        if saveData.array(forKey: "Detail") != nil {
            detailArray = saveData.array(forKey: "Detail") as![Dictionary<String,String>]
        }
                }
        // Do any additional setup after loading the view.
    }

        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


