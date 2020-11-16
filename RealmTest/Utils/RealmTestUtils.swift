//
//  RealmTestUtils.swift
//  RealmTest
//
//  Created by sopra on 11/11/2020.
//

import UIKit

struct RealmTestUtils {
    public static var apiKey: String {
        // 1
        guard let filePath = Bundle.main.path(forResource: "RealmTest", ofType: "plist") else {
            fatalError("Couldn't find file 'RealmTest.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'RealmTest.plist'.")
        }
        return value
    }

    enum URL {
        static let main = "https://api.themoviedb.org/"
    }

    enum Endpoints {
        static let urlPopularMoviesList = "3/movie/popular"
    }
}

@IBDesignable class CircleDrawView: UIView {
    @IBInspectable var borderColor = UIColor.black
    @IBInspectable var borderSize = CGFloat(4)

    override func draw(_ rec: CGRect) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderSize
        layer.cornerRadius = frame.height / 2
    }
}

public class Utils {
    public func generateID() -> Int {
        let minimumRandom: Int = 99999
        let maximumRandom: Int = 9999999999

        return Int.random(in: minimumRandom ... maximumRandom)
    }
}
