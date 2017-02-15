//
//  MovieClickViewController.swift
//  Flicks
//
//  Created by Prakash Pudhucode on 2/14/17.
//  Copyright © 2017 Prakash Pudhucode. All rights reserved.
//

import UIKit

class MovieClickViewController: UIViewController {
    
    var photo: UIImage!
    var movieTitle: String!
    var summary: String!
    var ratingnum: String!
    

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var movieSummary: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitleLabel.text = movieTitle
        movieSummary.text = summary
        detailImageView.image = photo
        rating.text = ratingnum
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
