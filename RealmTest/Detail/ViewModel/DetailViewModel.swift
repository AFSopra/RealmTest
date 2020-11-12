//
//  DetailViewModel.swift
//  RealmTest
//
//  Created by sopra on 10/11/2020.
//

import Foundation

class DetailViewModel {
    private var view: DetailViewController?
    private var router: DetailRouter?

    func bind(view: DetailViewController, router: DetailRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
}
