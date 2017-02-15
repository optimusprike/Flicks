//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Prakash Pudhucode on 1/30/17.
//  Copyright © 2017 Prakash Pudhucode. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var rating: Double!
    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary]?
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        // Do any additional setup after loading the view.
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        loadData(refreshControl: refreshControl)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        loadData(refreshControl: refreshControl)
    }
    
    func loadData(refreshControl: UIRefreshControl){
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(responseDictionary)
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.movies = (responseDictionary["results"] as! [NSDictionary])
                    
                    self.tableView.reloadData()
                    refreshControl.endRefreshing()
                }
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        let posterpath  = movie["poster_path"] as! String
        rating  = movie["vote_average"] as! Double
        let imageURL = NSURL(string: baseURL + posterpath)
        
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.movieImageView.setImageWith(imageURL as! URL)
        
        
        print("row \(indexPath.row)")
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! MovieClickViewController
        
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
        let mcell = tableView.cellForRow(at: indexPath!) as! MovieCell
        
        destinationViewController.photo = mcell.movieImageView.image
        destinationViewController.summary = mcell.overviewLabel.text
        destinationViewController.movieTitle = mcell.titleLabel.text
        let c:String = String(format:"%.1f", rating)
        destinationViewController.ratingnum = c
    }

    
}
