import Foundation

final class RocketsDataManager {
    static let shared = RocketsDataManager() // Синглтон
    private var rockets: [RocketsModel] = [] // Локальный кэш
    private var isDataLoaded = false // Флаг для проверки загрузки
    private let api = RocketsAPI() // Ваш API клиент
    
    private init() {} // Закрываем инициализатор, чтобы никто не мог создать другой экземпляр
    
    func fetchRockets(completion: @escaping ([RocketsModel]) -> Void) {
        // Если данные уже загружены, возвращаем их из кэша
        if isDataLoaded {
            completion(rockets)
            return
        }
        
        // Загружаем данные из API
        api.getData { [weak self] (loadedRockets: [RocketsModel]) in
            guard let self = self else { return }
            self.rockets = loadedRockets
            self.isDataLoaded = true
            completion(loadedRockets)
        }
    }
}
