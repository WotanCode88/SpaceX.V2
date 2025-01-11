import Foundation

final class RocketsAPI {
    
    var rockets: [RocketsModel] = []
    
    public func getData(completion: @escaping ([RocketsModel]) -> Void) {
        let session = URLSession.shared

        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }

        session.dataTask(with: url) { data, response, error in
            if error == nil, let parsData = data {
                let decoder = JSONDecoder()
                do {
                    let decodeData = try decoder.decode([RocketsModel].self, from: parsData)

                    // Передаем данные через completion
                    DispatchQueue.main.async {
                        self.rockets = decodeData
                        completion(decodeData) // Возвращаем данные
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}
