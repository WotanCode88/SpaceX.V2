import Foundation

final class LaunchesAPI {
    var launches: [LaunchesModel] = []
    
    func fetchLaunches(completion: @escaping (Result<[LaunchesModel], Error>) -> Void) {
        let urlString = "https://api.spacexdata.com/v4/launches"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data returned", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let fetchedLaunches = try JSONDecoder().decode([LaunchesModel].self, from: data)
                completion(.success(fetchedLaunches))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
