//
//  HomeRouter.swift
//  RealmTest
//
//  Created by sopra on 10/11/2020.
//

import UIKit

class HomeRouter {
    var viewController: UIViewController {
        return self.createViewController()
    }

    private var sourceView: UIViewController?

    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }

    fileprivate func createViewController() -> UIViewController {
        return HomeViewController(nibName: "HomeViewController", bundle: Bundle.main)
    }

    func navigateToAddTaskViewController() {
        let addTaskViewController = AddTaskRouter().viewController
        sourceView?.navigationController?.pushViewController(addTaskViewController, animated: true)
    }

    func navigateToDetailViewController(movie: Movie? = nil, movieRealm: MovieRealm? = nil) {
        if let detailViewController = DetailRouter().viewController as? DetailViewController {
            detailViewController.navigationItem.title = movie?.title
            detailViewController.movie = movie
            detailViewController.movieRealm = movieRealm
            sourceView?.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
