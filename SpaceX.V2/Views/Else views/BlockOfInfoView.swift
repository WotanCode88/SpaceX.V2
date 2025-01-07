//import UIKit
//import SnapKit
//
//final class BlockOfInfoView: UIView {
//    
//    let nameOfRocket: String
//    
//    init (nameOfRocket: String) {
//        self.nameOfRocket = nameOfRocket
//        super.init(frame: .zero)
//        
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.backgroundColor = .clear
//        loadData()
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    let api = RocketsAPI()
//    var rockets: [RocketsModel] = []
//    
//    private func loadData() {
//        api.getData { [weak self] (rockets: [RocketsModel]) in
//            guard let self = self else { return }
//            
//            if rockets.isEmpty {
//                return
//            } else {
//                self.rockets = rockets
//                if let falcon9 = rockets.first(where: { $0.name == self.nameOfRocket }) {
//                    let firstStart1 = falcon9.firstFlight
//                    let country1 = falcon9.country
//                    let price1 = falcon9.costPerLaunch
//                    
//                    self.firstStart1.text = firstStart1
//                    self.country1.text = country1
//                    self.price1.text = String("$\(price1 / 1000000) млн")
//                    
//                    let countEngines1FirstStage = falcon9.firstStage.engines
//                    let countFuel1FirstStage = falcon9.firstStage.fuelAmountTons
//                    let timeUntilBurn1FirstStage = falcon9.firstStage.burnTimeSEC ?? 0
//                    
//                    self.countEngines1FirstStage.text = String(countEngines1FirstStage)
//                    self.countFuel1FirstStage.text = String("\(countFuel1FirstStage) тонн")
//                    self.timeUntilBurn1FirstStage.text = String("\(timeUntilBurn1FirstStage) сек")
//                    
//                    let countEngines1SecondStage = falcon9.secondStage.engines
//                    let countFuel1SecondStage = falcon9.secondStage.fuelAmountTons
//                    let timeUntilBurn1SecondStage = falcon9.secondStage.burnTimeSEC ?? 0
//                    
//                    self.countEngines1SecondStage.text = String(countEngines1SecondStage)
//                    self.countFuel1SecondStage.text = String("\(countFuel1SecondStage) тонн")
//                    self.timeUntilBurn1SecondStage.text = String("\(timeUntilBurn1SecondStage) сек")
//                } else {
//                    return
//                }
//            }
//        }
//    }
//
//    let firstStart = createInfoRocketView(title: "Первый запуск", color: .systemGray)
//    let country = createInfoRocketView(title: "Страна", color: .systemGray)
//    let price = createInfoRocketView(title: "Стоимость запуска", color: .systemGray)
//    
//    var firstStart1 = createInfoRocketView(title: "X", color: .white)
//    let country1 = createInfoRocketView(title: "X", color: .white)
//    let price1 = createInfoRocketView(title: "$X млн", color: .white)
//    
//    let countEnginesFirstStage = createInfoRocketView(title: "Количество двигателей", color: .systemGray)
//    let countFuelFirstStage = createInfoRocketView(title: "Количество топлива", color: .systemGray)
//    let timeUntilBurnFirstStage = createInfoRocketView(title: "Время сгорания", color: .systemGray)
//    
//    var countEngines1FirstStage = createInfoRocketView(title: "X", color: .white)
//    var countFuel1FirstStage = createInfoRocketView(title: "X тонн", color: .white)
//    var timeUntilBurn1FirstStage = createInfoRocketView(title: "X часов", color: .white)
//    
//    let countEnginesSecondStage = createInfoRocketView(title: "Количество двигателей", color: .systemGray)
//    let countFuelSecondStage = createInfoRocketView(title: "Количество топлива", color: .systemGray)
//    let timeUntilBurnSecondStage = createInfoRocketView(title: "Время сгорания", color: .systemGray)
//    
//    var countEngines1SecondStage = createInfoRocketView(title: "X", color: .white)
//    var countFuel1SecondStage = createInfoRocketView(title: "X тонн", color: .white)
//    var timeUntilBurn1SecondStage = createInfoRocketView(title: "X часов", color: .white)
//    
//    let firstStage = createStageLabel("Первая ступень")
//    let secondStage = createStageLabel("Вторая ступень")
//    
//    static func createStageLabel(_ text: String) -> UILabel {
//        let title = UILabel()
//        title.text = text
//        title.textColor = .white
//        title.font = UIFont.boldSystemFont(ofSize: 24)
//        title.translatesAutoresizingMaskIntoConstraints = false
//        return title
//    }
//    
//    static func createInfoRocketView(title: String, color: UIColor) -> UILabel {
//        let text = UILabel()
//        text.text = title
//        text.textColor = color
//        text.font = UIFont.systemFont(ofSize: 16)
//        text.translatesAutoresizingMaskIntoConstraints = false
//        return text
//    }
//    
//    let baseInfoStackViewLeftSide = createStackView(.leading)
//    let baseInfoStackViewRightSide = createStackView(.trailing)
//    
//    let stackViewFirstStageLeftSide = createStackView(.leading)
//    let stackViewFirstStageRightSide = createStackView(.trailing)
//    
//    let stackViewSecondStageLeftSide = createStackView(.leading)
//    let stackViewSecondStageRightSide = createStackView(.trailing)
//    
//    static func createStackView(_ aligment: UIStackView.Alignment) -> UIStackView {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        stackView.spacing = 15
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.alignment = aligment
//        return stackView
//    }
//
//    private func setupUI () {
//        [firstStage, secondStage, stackViewFirstStageLeftSide,
//         stackViewSecondStageLeftSide, stackViewSecondStageRightSide,
//         stackViewFirstStageRightSide, baseInfoStackViewLeftSide,
//         baseInfoStackViewRightSide].forEach { addSubview($0) }
//        
//        [firstStart, country, price].forEach { baseInfoStackViewLeftSide.addArrangedSubview($0) }
//        [firstStart1, country1, price1].forEach { baseInfoStackViewRightSide.addArrangedSubview($0) }
//        
//        [countEnginesFirstStage, countFuelFirstStage, timeUntilBurnFirstStage].forEach { stackViewFirstStageLeftSide.addArrangedSubview($0) }
//        [countEngines1FirstStage, countFuel1FirstStage, timeUntilBurn1FirstStage].forEach { stackViewFirstStageRightSide.addArrangedSubview($0) }
//        
//        [countEnginesSecondStage, countFuelSecondStage, timeUntilBurnSecondStage].forEach { stackViewSecondStageLeftSide.addArrangedSubview($0) }
//        [countEngines1SecondStage, countFuel1SecondStage, timeUntilBurn1SecondStage].forEach { stackViewSecondStageRightSide.addArrangedSubview($0) }
//        
//        // Устанавливаем автолэйауты с использованием SnapKit
//        firstStage.snp.makeConstraints { make in
//            make.top.equalTo(baseInfoStackViewLeftSide.snp.bottom).offset(40)
//            make.leading.equalTo(baseInfoStackViewLeftSide.snp.leading)
//        }
//        
//        stackViewFirstStageLeftSide.snp.makeConstraints { make in
//            make.top.equalTo(firstStage.snp.bottom).offset(15)
//            make.leading.equalTo(firstStage.snp.leading)
//        }
//        
//        stackViewFirstStageRightSide.snp.makeConstraints { make in
//            make.centerY.equalTo(stackViewFirstStageLeftSide.snp.centerY)
//            make.trailing.equalTo(baseInfoStackViewRightSide.snp.trailing)
//        }
//        
//        secondStage.snp.makeConstraints { make in
//            make.top.equalTo(stackViewFirstStageLeftSide.snp.bottom).offset(40)
//            make.leading.equalTo(stackViewFirstStageLeftSide.snp.leading)
//        }
//        
//        stackViewSecondStageLeftSide.snp.makeConstraints { make in
//            make.top.equalTo(secondStage.snp.bottom).offset(15)
//            make.leading.equalTo(secondStage.snp.leading)
//        }
//        
//        stackViewSecondStageRightSide.snp.makeConstraints { make in
//            make.centerY.equalTo(stackViewSecondStageLeftSide.snp.centerY)
//            make.trailing.equalTo(stackViewFirstStageRightSide.snp.trailing)
//            make.bottom.equalTo(self.snp.bottom)
//        }
//        
//        baseInfoStackViewLeftSide.snp.makeConstraints { make in
//            make.top.equalTo(self.snp.top).offset(40)
//            make.leading.equalTo(self.snp.leading).offset(30)
//        }
//        
//        baseInfoStackViewRightSide.snp.makeConstraints { make in
//            make.centerY.equalTo(baseInfoStackViewLeftSide.snp.centerY)
//            make.trailing.equalTo(self.snp.trailing).offset(-30)
//        }
//    }
//}
//