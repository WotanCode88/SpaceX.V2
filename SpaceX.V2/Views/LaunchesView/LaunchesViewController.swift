import UIKit

final class LaunchesViewController: UIViewController {
    
    private let rocket: String
    private var launches: [LaunchesModel] = []
    
    init(rocket: String) {
        self.rocket = rocket
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        navigationItem.title = rocket
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black

        setupUI()
        fetchLaunches(forRocket: rocket)
    }
    
    private let navBarBack: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Массив для хранения информации о запусках
    private var launchesInfo: [RocketInfoSquareView] = []

    // UIScrollView для прокрутки
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // Контейнер для всех элементов внутри scrollView
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        view.addSubview(navBarBack)
        NSLayoutConstraint.activate([
            navBarBack.topAnchor.constraint(equalTo: view.topAnchor),
            navBarBack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarBack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBarBack.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 110)
        ])
        
        // Настройка constraints для scrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Настройка contentView внутри scrollView
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // Контейнер растягивается по ширине экрана
        ])
        
        // Добавляем stackView внутрь contentView
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }


    private func fetchLaunches(forRocket rocketName: String) {
        let urlString = "https://api.spacexdata.com/v4/launches/past"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Ошибка: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                // Декодируем данные
                let launches = try JSONDecoder().decode([LaunchesModel].self, from: data)
                
                // Фильтруем запуски по имени ракеты
                let filteredLaunches = launches.filter { $0.rocket.name == rocketName }
                self?.launches = filteredLaunches
                
                // Обновляем UI на главном потоке
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            } catch {
                print("Ошибка при декодировании данных: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    // Функция для обновления UI
    private func updateUI() {
        // Форматирование даты
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"  // Формат для оригинальной строки даты в API
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")  // Важно указать правильный часовой пояс, если он в UTC

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"  // Формат для вывода только даты
        
        // Заполняем массив RocketInfoSquareView с информацией о каждом запуске
        launchesInfo = launches.map { launch in
            // Преобразуем строку с датой в объект Date
            if let launchDate = dateFormatter.date(from: launch.dateUTC) {
                // Преобразуем Date в строку с нужным форматом
                let formattedDate = outputFormatter.string(from: launchDate)
                
                return RocketInfoSquareView(title: launch.name,
                                            subtitle: formattedDate,  // Выводим только дату
                                            success: launch.success ?? false)
            } else {
                // Если дата невалидна, возвращаем пустую строку
                return RocketInfoSquareView(title: launch.name,
                                            subtitle: "",
                                            success: launch.success ?? false)
            }
        }

        // Добавляем их в stackView
        launchesInfo.forEach { stackView.addArrangedSubview($0) }
    }

    // StackView для размещения карточек
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}
