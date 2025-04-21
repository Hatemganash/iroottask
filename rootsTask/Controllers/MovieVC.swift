//
//  MovieVC.swift
//  rootsTask
//
//  Created by Hatem on 21/04/2025.
//

import UIKit
import Alamofire

class MovieVC: BaseVC {

    //MARK: - IBOutlets
    @IBOutlet weak var moviewNameTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    //MARK: - Properties
    var movies: [MovieModelElement] = []

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMovies()
    }
}

//MARK: - Configurations
extension MovieVC {
    func setupTableView(){
        moviewNameTableView.dataSource = self
        moviewNameTableView.delegate = self
        moviewNameTableView.registerTVCell(cellClass: MovieNameCell.self)
        
    }
    func getMovies() {
        loader.startAnimating()

        if NetworkReachabilityManager()?.isReachable == true {
            let headers: HTTPHeaders = [
                "Accept-Language": currentLanguage.lowercased()
                   ]
            AF.request("https://www.freetestapi.com/api/v1/movies", headers: headers)
                .responseDecodable(of: [MovieModelElement].self) { response in
                    self.loader.stopAnimating()

                    switch response.result {
                    case .success(let data):
                        self.movies = data
                        self.saveToCache(data)
                        self.moviewNameTableView.reloadData()
                        self.showToast(message: "Data get successfully")
                    case .failure(let error):
                        print("API error: \(error.localizedDescription)")
                        self.loadFromCache()
                    }
                }
        } else {
            // ❌ Offline: load from cache
            print("Offline - loading cached movies")
            loadFromCache()
            self.loader.stopAnimating()
        }
    }

    private func saveToCache(_ data: [MovieModelElement]) {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: "cachedMovies")
        }
    }

    private func loadFromCache() {
        if let savedData = UserDefaults.standard.data(forKey: "cachedMovies"),
            let decoded = try? JSONDecoder().decode(
                [MovieModelElement].self, from: savedData)
        {
            self.movies = decoded
            self.moviewNameTableView.reloadData()
            self.showToast(message: "No internet , Cashed data get successfully")
        } else {
            print("No cached data found.")
            self.showToast(message: "No internet and no cached data found.")
        }
    }
}

//MARK: - UITableView Configurations

extension MovieVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell : MovieNameCell = moviewNameTableView.dequeue(inx: indexPath)
        let movie = movies[indexPath.row]
        cell.setupData(data: movie)
        return cell
    }
}
