//
//  HomeViewController.swift
//  RealmTest
//
//  Created by sopra on 10/11/2020.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var managerConnections = ManagerConnections()

    private var movies: [Movie]?
    private var moviesRealm = [MovieRealm]()

    lazy var realm: Realm = {
        return try! Realm()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.bind(view: self, router: router)

        self.getData()
        self.addNavButton()
        self.setupUI()
        self.setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refresh()
    }

    fileprivate func getData() {
        if realm.objects(MovieRealm.self).map({ $0 }).isEmpty {
            self.managerConnections.getPopularMovies() { (movies, error) in
                self.movies = movies

                if !(self.movies?.isEmpty ?? false) {
                    self.saveDataToRealm()
                }

                if error != nil {
                    print(error)
                }
            }
        } else {
            self.updateMoviesArray()
        }
    }

    fileprivate func setupUI() {
        self.navigationItem.title = "Home"
    }

    fileprivate func setupTableView() {
        self.tableView.register(UINib(nibName: "CustomCell", bundle: Bundle.main), forCellReuseIdentifier: "CustomCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    fileprivate func addNavButton() {
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        let deleteAllButton = UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(deleteAllTapped))
        self.navigationItem.leftBarButtonItem = deleteAllButton
        self.navigationItem.rightBarButtonItem = addButton
    }

    @objc func addTapped() {
        self.viewModel.makeAddTaskView()
    }

    @objc func deleteAllTapped() {
        realm.beginWrite()
        realm.deleteAll()
        try? realm.commitWrite()

        self.refresh()
    }

    func updateMoviesArray() {
        self.movies = []

        for movie in self.moviesRealm {
            self.movies?.append(Movie(movieID: movie.movieID, title: movie.title, voteAverage: movie.voteAverage))
        }
    }

    func refresh() {
        self.moviesRealm = realm.objects(MovieRealm.self).map({ $0 })
        self.updateMoviesArray()
        self.reloadTableView()
    }

    fileprivate func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    fileprivate func saveDataToRealm() {
        if let movies = self.movies {
            for i in 0...movies.count - 1 {
                realm.beginWrite()

                let movieAux = MovieRealm()
                movieAux.movieID = self.movies?[i].movieID ?? 0
                movieAux.title = self.movies?[i].title ?? ""
                movieAux.voteAverage = self.movies?[i].voteAverage ?? 0.0

                realm.add(movieAux)

                try? realm.commitWrite()
            }
        }

        self.refresh()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if realm.objects(MovieRealm.self).map({ $0 }).isEmpty {
            return self.movies?.count ?? -1
        } else {
            return self.moviesRealm.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell {
            if realm.objects(MovieRealm.self).map({ $0 }).isEmpty {
                cell.setLabels(title: self.movies?[indexPath.row].title ?? "", voteAverage: self.movies?[indexPath.row].voteAverage ?? 0.0)
            } else {
                cell.setLabels(title: self.moviesRealm[indexPath.row].title, voteAverage: self.moviesRealm[indexPath.row].voteAverage)
            }
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieRealmAux = MovieRealm()

        tableView.deselectRow(at: indexPath, animated: true)

        if realm.objects(MovieRealm.self).map({ $0 }).isEmpty {
            movieRealmAux.movieID = self.movies?[indexPath.row].movieID ?? 0
            movieRealmAux.title = self.movies?[indexPath.row].title ?? ""
            movieRealmAux.voteAverage = self.movies?[indexPath.row].voteAverage ?? 0.0
        } else {
            movieRealmAux.movieID = self.moviesRealm[indexPath.row].movieID
            movieRealmAux.title = self.moviesRealm[indexPath.row].title
            movieRealmAux.voteAverage = self.moviesRealm[indexPath.row].voteAverage
        }

        self.router.navigateToDetailViewController(movie: self.movies?[indexPath.row], movieRealm: movieRealmAux)
    }
}
