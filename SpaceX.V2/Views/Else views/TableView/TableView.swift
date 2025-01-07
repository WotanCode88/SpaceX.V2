import UIKit
import SnapKit

class RocketInfoTableViewController: UITableViewController {
    
    let rocketName: String
    var rocket: RocketsModel?

    init(rocketName: String) {
        self.rocketName = rocketName
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        tableView.register(RocketInfoTableViewCell.self, forCellReuseIdentifier: RocketInfoTableViewCell.reuseIdentifier)
        
        tableView.rowHeight = 38 // Устанавливает фиксированную высоту ячеек
        tableView.isScrollEnabled = false

        loadData()
    }
    
    private func loadData() {
        RocketsDataManager.shared.fetchRockets { [weak self] rockets in
            guard let self = self else { return }
            if let rocket = rockets.first(where: { $0.name == self.rocketName }) {
                self.rocket = rocket
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3  // Первый раздел: общая информация, второй и третий - для ступеней
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 3 // Общая информация (например, первый запуск, страна, стоимость)
        case 1: return 3 // Первая ступень
        case 2: return 3 // Вторая ступень
        default: return 0
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1, 2:
            return 40 // Увеличиваем высоту заголовка секции
        default:
            return 0 // Без заголовка
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RocketInfoTableViewCell.reuseIdentifier, for: indexPath) as! RocketInfoTableViewCell
        guard let rocket = rocket else { return cell }
        
        var title = ""
        var value = ""
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                title = "Первый запуск"
                value = rocket.firstFlight
            case 1:
                title = "Страна"
                value = rocket.country
            case 2:
                title = "Стоимость запуска"
                value = "$\(rocket.costPerLaunch / 1000000) млн"
            default: break
            }
        case 1:
            switch indexPath.row {
            case 0:
                title = "Количество двигателей"
                value = String(rocket.firstStage.engines)
            case 1:
                title = "Количество топлива"
                value = "\(rocket.firstStage.fuelAmountTons) тонн"
            case 2:
                title = "Время сгорания"
                value = "\(rocket.firstStage.burnTimeSEC ?? 0) сек"
            default: break
            }
        case 2:
            switch indexPath.row {
            case 0:
                title = "Количество двигателей"
                value = String(rocket.secondStage.engines)
            case 1:
                title = "Количество топлива"
                value = "\(rocket.secondStage.fuelAmountTons) тонн"
            case 2:
                title = "Время сгорания"
                value = "\(rocket.secondStage.burnTimeSEC ?? 0) сек"
            default: break
            }
        default: break
        }
        
        cell.configure(title: title, value: value)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1: return "Первая ступень"
        case 2: return "Вторая ступень"
        default: return nil
        }
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        // Настройка цвета текста
        header.textLabel?.textColor = .white
        
        // Настройка шрифта
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    }
}
