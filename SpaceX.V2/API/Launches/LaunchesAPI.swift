import Foundation

final class LaunchesAPI {
    // Массив для хранения данных
    var launches: [LaunchesModel] = []
    
    // Функция для выполнения запроса
    func fetchLaunches(completion: @escaping (Result<[LaunchesModel], Error>) -> Void) {
        // URL API
        let urlString = "https://api.spacexdata.com/v4/launches"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        // Создание запроса
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Выполнение запроса
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
                // Декодирование ответа
                let fetchedLaunches = try JSONDecoder().decode([LaunchesModel].self, from: data)
                completion(.success(fetchedLaunches))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // Метод для запуска запроса
    func startFetching() {
        fetchLaunches { [weak self] result in
            switch result {
            case .success(let fetchedLaunches):
                // Сохраняем данные в массив
                self?.launches = fetchedLaunches
                
                // Пример взаимодействия с массивом
                print("Всего запусков: \(fetchedLaunches.count)")
                if let firstLaunch = fetchedLaunches.first {
                    print("Первый запуск:")
                    print("Название: \(firstLaunch.name)")
                    print("Дата (UTC): \(firstLaunch.dateUTC)")
                    print("Детали: \(firstLaunch.details ?? "Нет деталей")")
                }
            case .failure(let error):
                print("Ошибка при получении запусков: \(error.localizedDescription)")
            }
        }
    }
}


