import UIKit

final class BlockOfInfoView: UIView {
    
    let nameOfRocket: String
    
    init (nameOfRocket: String) {
        self.nameOfRocket = nameOfRocket
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        loadData()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let api = RocketsAPI()
     var rockets: [RocketsModel] = []
    
    private func loadData() {
        api.getData { [weak self] (rockets: [RocketsModel]) in
            guard let self = self else { return }
            
            if rockets.isEmpty {
                return
            } else {
                self.rockets = rockets
                if let falcon9 = rockets.first(where: { $0.name == self.nameOfRocket }) {
                    let firstStart1 = falcon9.firstFlight
                    let country1 = falcon9.country
                    let price1 = falcon9.costPerLaunch
                    
                    self.firstStart1.text = firstStart1
                    self.country1.text = country1
                    self.price1.text = String("$\(price1 / 1000000) млн")
                    
                    let countEngines1FirstStage = falcon9.firstStage.engines
                    let countFuel1FirstStage = falcon9.firstStage.fuelAmountTons
                    let timeUntilBurn1FirstStage = falcon9.firstStage.burnTimeSEC ?? 0
                    
                    self.countEngines1FirstStage.text = String(countEngines1FirstStage)
                    self.countFuel1FirstStage.text = String("\(countFuel1FirstStage) тонн")
                    self.timeUntilBurn1FirstStage.text = String("\(timeUntilBurn1FirstStage) сек")
                    
                    let countEngines1SecondStage = falcon9.secondStage.engines
                    let countFuel1SecondStage = falcon9.secondStage.fuelAmountTons
                    let timeUntilBurn1SecondStage = falcon9.secondStage.burnTimeSEC ?? 0
                    
                    self.countEngines1SecondStage.text = String(countEngines1SecondStage)
                    self.countFuel1SecondStage.text = String("\(countFuel1SecondStage) тонн")
                    self.timeUntilBurn1SecondStage.text = String("\(timeUntilBurn1SecondStage) сек")
                } else {
                    return
                }
            }
        }
    }
    
    //
    
    let firstStart = createInfoRocetView(title: "Первый запуск", color: .systemGray)
    let country = createInfoRocetView(title: "Страна", color: .systemGray)
    let price = createInfoRocetView(title: "Стоимость запуска", color: .systemGray)
    
    var firstStart1 = createInfoRocetView(title: "X", color: .white)
    let country1 = createInfoRocetView(title: "X", color: .white)
    let price1 = createInfoRocetView(title: "$X млн", color: .white)
    
    // 1 stage
    
    let countEnginesFirstStage = createInfoRocetView(title: "Количество двигателей",
                                                     color: .systemGray)
    let countFuelFirstStage = createInfoRocetView(title: "Количество топлива",
                                                    color: .systemGray)
    let timeUntilBurnFirstStage = createInfoRocetView(title: "Время сгорания",
                                                      color: .systemGray)
    
    var countEngines1FirstStage = createInfoRocetView(title: "X", color: .white)
    var countFuel1FirstStage = createInfoRocetView(title: "X тонн", color: .white)
    var timeUntilBurn1FirstStage = createInfoRocetView(title: "X часов", color: .white)
    
    // 2 stage
    
    let countEnginesSecondStage = createInfoRocetView(title: "Количество двигателей",
                                                     color: .systemGray)
    let countFuelSecondStage = createInfoRocetView(title: "Количество топлива",
                                                    color: .systemGray)
    let timeUntilBurnSecondStage = createInfoRocetView(title: "Время сгорания",
                                                      color: .systemGray)
    
    var countEngines1SecondStage = createInfoRocetView(title: "X", color: .white)
    var countFuel1SecondStage = createInfoRocetView(title: "X тонн", color: .white)
    var timeUntilBurn1SecondStage = createInfoRocetView(title: "X часов", color: .white)
    
    //
    
    let firstStage = createStageLabel("Первая ступень")
    let secondStage = createStageLabel("Вторая ступень")
    
    static func createStageLabel(_ text: String) -> UILabel {
        let title = UILabel()
        title.text = text
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 24)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }
    
    static func createInfoRocetView(title: String, color: UIColor) -> UILabel {
        let text = UILabel()
        text.text = title
        text.textColor = color
        text.font = UIFont.systemFont(ofSize: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }
    
    let baseInfoStackViewLeftSide = createStackView(.leading)
    let baseInfoStackViewRightSide = createStackView(.trailing)
    
    let stackViewFirstStageLeftSide = createStackView(.leading)
    let stackViewFirstStageRightSide = createStackView(.trailing)
    
    let stackViewSecondStageLeftSide = createStackView(.leading)
    let stackViewSecondStageRightSide = createStackView(.trailing)
    
    static func createStackView(_ aligment: UIStackView.Alignment) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = aligment
        return stackView
    }

    private func setupUI () {
        [firstStage, secondStage, stackViewFirstStageLeftSide,
                         stackViewSecondStageLeftSide, stackViewSecondStageRightSide,
                         stackViewFirstStageRightSide, baseInfoStackViewLeftSide,
                         baseInfoStackViewRightSide]
            .forEach {self.addSubview($0)}
        
        [firstStart ,country, price].forEach{ baseInfoStackViewLeftSide.addArrangedSubview($0) }
        [firstStart1, country1, price1].forEach{ baseInfoStackViewRightSide.addArrangedSubview($0)}
        
        [countEnginesFirstStage, countFuelFirstStage, timeUntilBurnFirstStage].forEach{ stackViewFirstStageLeftSide.addArrangedSubview($0) }
        [countEngines1FirstStage, countFuel1FirstStage, timeUntilBurn1FirstStage].forEach{ stackViewFirstStageRightSide.addArrangedSubview($0) }
        
        [countEnginesSecondStage, countFuelSecondStage, timeUntilBurnSecondStage].forEach{ stackViewSecondStageLeftSide.addArrangedSubview($0) }
        [countEngines1SecondStage, countFuel1SecondStage, timeUntilBurn1SecondStage]
            .forEach{ stackViewSecondStageRightSide.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            // first info stack
            baseInfoStackViewLeftSide.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            baseInfoStackViewLeftSide.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            
            baseInfoStackViewRightSide.centerYAnchor.constraint(equalTo: baseInfoStackViewLeftSide.centerYAnchor),
            baseInfoStackViewRightSide.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            // first stage title
            firstStage.topAnchor.constraint(equalTo: baseInfoStackViewLeftSide.bottomAnchor, constant: 40),
            firstStage.leadingAnchor.constraint(equalTo: baseInfoStackViewLeftSide.leadingAnchor),
            
            stackViewFirstStageLeftSide.topAnchor.constraint(equalTo: firstStage.bottomAnchor, constant: 15),
            stackViewFirstStageLeftSide.leadingAnchor.constraint(equalTo: firstStage.leadingAnchor),
            
            stackViewFirstStageRightSide.centerYAnchor.constraint(equalTo: stackViewFirstStageLeftSide.centerYAnchor),
            stackViewFirstStageRightSide.trailingAnchor.constraint(equalTo: baseInfoStackViewRightSide.trailingAnchor),
            
            // second stage title
            secondStage.topAnchor.constraint(equalTo: stackViewFirstStageLeftSide.bottomAnchor, constant: 40),
            secondStage.leadingAnchor.constraint(equalTo: stackViewFirstStageLeftSide.leadingAnchor),
            
            stackViewSecondStageLeftSide.topAnchor.constraint(equalTo: secondStage.bottomAnchor, constant: 15),
            stackViewSecondStageLeftSide.leadingAnchor.constraint(equalTo: secondStage.leadingAnchor),
            
            stackViewSecondStageRightSide.centerYAnchor.constraint(equalTo: stackViewSecondStageLeftSide.centerYAnchor),
            stackViewSecondStageRightSide.trailingAnchor.constraint(equalTo: stackViewFirstStageRightSide.trailingAnchor),
            stackViewSecondStageRightSide.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
