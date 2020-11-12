//
//  RealmTestUtils.swift
//  RealmTest
//
//  Created by sopra on 11/11/2020.
//

import UIKit

struct RealmTestUtils {
    static let apiKey = "?api_key=067f5f0549fc4dee8c6e3be847418daa"

    struct URL {
        static let main = "https://api.themoviedb.org/"
    }

    struct Endpoints {
        static let urlPopularMoviesList = "3/movie/popular"
    }
}

@IBDesignable class CircleDrawView: UIView {

    @IBInspectable var borderColor: UIColor = UIColor.black
    @IBInspectable var borderSize: CGFloat = CGFloat(4)

    override func draw(_ rec: CGRect) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderSize
        layer.cornerRadius = self.frame.height / 2
    }
}

public class Utils {
    public func generateID() -> Int {
        let minimumRandom: Int = 99999
        let maximumRandom: Int = 9999999999

        return Int.random(in: minimumRandom...maximumRandom)
    }
}


