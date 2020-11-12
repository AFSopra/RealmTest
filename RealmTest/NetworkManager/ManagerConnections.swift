//
//  ManagerConnections.swift
//  RealmTest
//
//  Created by sopra on 11/11/2020.
//

import Foundation

class ManagerConnections {
    func getPopularMovies(completion: @escaping (_ movies: [Movie], _ error: Error?) -> Void) {
        guard let url = URL(string: RealmTestUtils.URL.main + RealmTestUtils.Endpoints.urlPopularMoviesList + RealmTestUtils.apiKey) else { return completion([], nil) }
        let session = URLSession.shared

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        session.dataTask(with: request) { (data, response, error) in

            guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return print("Error - Fallo de conexión") }

            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    var movies = try decoder.decode(Movies.self, from: data)

                    for movie in movies.moviesList {
                        let movieAuxiliar = Movie(movieID: movie.movieID, title: movie.title, voteAverage: movie.voteAverage)
                        movies.moviesList.append(movieAuxiliar)
                    }

                    DispatchQueue.main.async {
                        completion(movies.moviesList, nil)
                    }
                } catch let error {
                    print("Error \(response.statusCode) - \(String(describing: error.localizedDescription))")
                }
            } else if response.statusCode == 401 {
                print("Error \(response.statusCode) - \(String(describing: error?.localizedDescription))")
            }
        }.resume()
        return completion([], nil)
    }
}
