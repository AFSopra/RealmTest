//
//  DetailViewController.swift
//  RealmTest
//
//  Created by sopra on 10/11/2020.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {

    @IBOutlet private weak var movieIDLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!

    private var router = DetailRouter()
    private var viewModel = DetailViewModel()

    private var realm = try? Realm()

    public var movie: Movie?
    public var movieRealm: MovieRealm?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.bind(view: self, router: router)
        self.setupUI()
        self.addNavButton()
    }

    public func setupUI() {
        if let movie = self.movie {
            self.movieIDLabel.text = "ID: " + String(describing: movie.movieID)
            self.titleLabel.text = "Título: " + movie.title
            self.voteAverageLabel.text = "Votación: " + String(describing: movie.voteAverage)
        }
    }

    fileprivate func addNavButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteTapped))
    }

    @objc func deleteTapped() {
        guard let realm = self.realm else { return }
        if let movie = self.movie {
            realm.beginWrite()

            let objectToDelete = realm.objects(MovieRealm.self).filter("movieID=%@", movie.movieID)

            realm.delete(objectToDelete)
            try? realm.commitWrite()

            self.router.navigateToHomeViewController()
        }
    }
}
