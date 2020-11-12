//
//  AddTaskViewController.swift
//  RealmTest
//
//  Created by sopra on 10/11/2020.
//

import UIKit
import RealmSwift

class AddTaskViewController: UIViewController {

    @IBOutlet private weak var titleTextField: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var sliderVote: UISlider!
    @IBOutlet private weak var voteAverage: UILabel!

    private var router = AddTaskRouter()
    private var viewModel = AddTaskViewModel()

    private let realm = try? Realm()
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = .halfUp
        formatter.maximumFractionDigits = 1
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.largeTitleDisplayMode = .never

        self.router.setSourceView(self)

        self.addNavButton()
        self.setupTextField()
        self.setupSlider()
        self.setupUI()
    }

    fileprivate func setupUI() {
        self.titleTextField.text = "Introduzca un título:"
        self.voteAverage.text = self.formatter.string(from: NSNumber(value: self.sliderVote.value))
    }

    fileprivate func setupTextField() {
        self.becomeFirstResponder()
        self.textField.delegate = self
    }

    fileprivate func setupSlider() {
        self.sliderVote.value = 5.0
        self.sliderVote.minimumValue = 0.0
        self.sliderVote.maximumValue = 10.0
    }

    fileprivate func addNavButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
    }

    @objc func saveTapped() {
        if let text = self.textField.text, !text.isEmpty {
            let voteAverage = Double(self.formatter.string(from: NSNumber(value: self.sliderVote.value)) ?? "") ?? 0.0
            let uiid = Utils().generateID()
            
            realm?.beginWrite()
            
            let newMovie = MovieRealm()
            
            newMovie.movieID = uiid
            newMovie.title = text
            newMovie.voteAverage = voteAverage
            
            realm?.add(newMovie)

            try? realm?.commitWrite()

            self.router.navigateToHomeViewController()
        }
    }

    @IBAction func sliderValueChanged(_ sender: Any) {
        self.voteAverage.text = self.formatter.string(from: NSNumber(value: self.sliderVote.value))
    }
}

extension AddTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
}
