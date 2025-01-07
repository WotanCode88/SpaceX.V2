import UIKit
import SnapKit

final class HorizontalView: UIView {
    private let rocketName: String

    // Состояния переключателей
    private var heightSystemIsOn: Bool {
        get { UserDefaults.standard.bool(forKey: "isOn1") }
        set { UserDefaults.standard.set(newValue, forKey: "isOn1") }
    }
    private var diametrSystemIsOn: Bool {
        get { UserDefaults.standard.bool(forKey: "isOn2") }
        set { UserDefaults.standard.set(newValue, forKey: "isOn2") }
    }
    private var weightSystemIsOn: Bool {
        get { UserDefaults.standard.bool(forKey: "isOn3") }
        set { UserDefaults.standard.set(newValue, forKey: "isOn3") }
    }
    private var payloadSystemIsOn: Bool {
        get { UserDefaults.standard.bool(forKey: "isOn4") }
        set { UserDefaults.standard.set(newValue, forKey: "isOn4") }
    }

    // Данные ракет
    private let api = RocketsAPI()
    private var rockets: [RocketsModel] = []

    // MARK: - Инициализация
    init(rocketName: String) {
        self.rocketName = rocketName
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        setupUI()
        setupNotificationObservers()
        loadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Уведомления
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSwitchState(_:)),
            name: NSNotification.Name("SwitchStateChanged"),
            object: nil
        )
    }

    @objc private func handleSwitchState(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let key = userInfo["key"] as? String,
              let state = userInfo["state"] as? Bool else { return }

        // Обновляем состояния
        switch key {
        case "isOn1":
            heightSystemIsOn = state
        case "isOn2":
            diametrSystemIsOn = state
        case "isOn3":
            weightSystemIsOn = state
        case "isOn4":
            payloadSystemIsOn = state
        default:
            break
        }

        // Перерисовываем UI
        if let theRocket = rockets.first(where: { $0.name == self.rocketName }) {
            updateUIForRocket(theRocket)
        }
    }

    // MARK: - Загрузка данных
    private func loadData() {
        RocketsDataManager.shared.fetchRockets { [weak self] rockets in
            guard let self = self else { return }
            self.rockets = rockets

            if let theRocket = rockets.first(where: { $0.name == self.rocketName }) {
                DispatchQueue.main.async {
                    self.updateUIForRocket(theRocket)
                }
            }
        }
    }

    // MARK: - Обновление UI
    private func updateUIForRocket(_ rocket: RocketsModel) {
        let heightUnit = heightSystemIsOn ? "ft" : "mt"
        let height = heightSystemIsOn ? rocket.height.feet : rocket.height.meters

        let diameterUnit = diametrSystemIsOn ? "ft" : "mt"
        let diameter = diametrSystemIsOn ? rocket.diameter.feet : rocket.diameter.meters

        let weightUnit = weightSystemIsOn ? "lb" : "kg"
        let weight = weightSystemIsOn ? rocket.mass.lb : rocket.mass.kg

        let payloadUnit = payloadSystemIsOn ? "lb" : "kg"
        let payload = payloadSystemIsOn ? rocket.payloadWeights.first?.lb : rocket.payloadWeights.first?.kg

        DispatchQueue.main.async {
            // Очищаем текущие элементы
            self.horizontalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

            // Добавляем новые элементы
            let squareInfoView1 = SquareInfoView(titleText: "\(height ?? 0)", subtitleText: "Высота (\(heightUnit))")
            let squareInfoView2 = SquareInfoView(titleText: "\(diameter ?? 0)", subtitleText: "Диаметр (\(diameterUnit))")
            let squareInfoView3 = SquareInfoView(titleText: "\(weight)", subtitleText: "Масса (\(weightUnit))")
            let squareInfoView4 = SquareInfoView(titleText: "\(payload ?? 0)", subtitleText: "Нагрузка (\(payloadUnit))")

            self.horizontalStackView.addArrangedSubview(squareInfoView1)
            self.horizontalStackView.addArrangedSubview(squareInfoView2)
            self.horizontalStackView.addArrangedSubview(squareInfoView3)
            self.horizontalStackView.addArrangedSubview(squareInfoView4)
        }
    }

    // MARK: - UI
    private let horizontalStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()

    private let horizontalScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    private func setupUI() {
        self.addSubview(horizontalScrollView)
        horizontalScrollView.addSubview(horizontalStackView)

        horizontalScrollView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(100)
        }

        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(horizontalScrollView.snp.top)
            make.leading.equalTo(horizontalScrollView.snp.leading)
            make.trailing.equalTo(horizontalScrollView.snp.trailing)
            make.bottom.equalTo(horizontalScrollView.snp.bottom)
            make.height.equalTo(horizontalScrollView.snp.height)
        }
    }
}
