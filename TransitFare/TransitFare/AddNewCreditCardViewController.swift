//
//  AddNewCreditCardViewController.swift
//  TransitFare
//
//  Created by ajaybeniwal203 on 3/2/16.
//  Copyright © 2016 ajaybeniwal203. All rights reserved.
//

import UIKit

class AddNewCreditCardViewController: UIViewController {

    @IBAction func cancelPopUp(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
