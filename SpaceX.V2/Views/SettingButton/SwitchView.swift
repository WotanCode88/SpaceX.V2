import UIKit

final class Switch: UIView {

    private let firstText: String
    private let secondText: String

    private let firstPosicion: UILabel
    private let secondPosicion: UILabel
    
    let keyForStatement: String
    var isSwitchOn: Bool // Состояние переключателя

    // MARK: - init
    init(firstText: String, secondText: String, keyForStatement: String) {
        self.firstText = firstText
        self.secondText = secondText
        self.keyForStatement = keyForStatement

        firstPosicion = UILabel()
        firstPosicion.text = firstText
        firstPosicion.font = UIFont.boldSystemFont(ofSize: 17)
        firstPosicion.translatesAutoresizingMaskIntoConstraints = false

        secondPosicion = UILabel()
        secondPosicion.text = secondText
        secondPosicion.font = UIFont.boldSystemFont(ofSize: 17)
        secondPosicion.translatesAutoresizingMaskIntoConstraints = false
        
        isSwitchOn = UserDefaults.standard.value(forKey: keyForStatement) as? Bool ?? false

        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        setColorsText()
        setupSelectors()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setColorsText() {
        if isSwitchOn {
            secondPosicion.textColor = .black
            firstPosicion.textColor = UIColor(named: "ColorForTextButton")
        } else {
            firstPosicion.textColor = .black
            secondPosicion.textColor = UIColor(named: "ColorForTextButton")
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 150, height: 50)
    }

    // MARK: - UI
    private let switchContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ColorForButton")
        view.layer.cornerRadius = 9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let switchButton: UIView = {
        let button = UIView()
        button.backgroundColor = .white
        button.layer.cornerRadius = 9
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var switchButtonLeadingConstraint: NSLayoutConstraint!

    // MARK: - setupSelectors
    func setupSelectors() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchTapped))
        switchContainer.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - switchTapped
    @objc func switchTapped() {
        isSwitchOn.toggle()
        setColorsText()
        
        var targetX: CGFloat
        if isSwitchOn {
            targetX = switchContainer.bounds.width - switchButton.bounds.width - 5
            UserDefaults.standard.set(true, forKey: keyForStatement)
        } else {
            targetX = 5
            UserDefaults.standard.set(false, forKey: keyForStatement)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.switchButtonLeadingConstraint.constant = targetX
            self.layoutIfNeeded() // Обновляем layout
        }, completion: { _ in
        })
        NotificationCenter.default.post(
            name: NSNotification.Name("SwitchStateChanged"),
            object: nil,
            userInfo: ["key": keyForStatement, "state": isSwitchOn]
        )
    }

    // MARK: - setupUI
    private func setupUI() {
        [switchContainer, switchButton, firstPosicion, secondPosicion].forEach { addSubview($0) }

        switchButtonLeadingConstraint = switchButton.leadingAnchor.constraint(equalTo: switchContainer.leadingAnchor, constant: isSwitchOn ? 70 : 5)
        
        NSLayoutConstraint.activate([
            firstPosicion.leadingAnchor.constraint(equalTo: switchContainer.leadingAnchor, constant: 25),
            firstPosicion.centerYAnchor.constraint(equalTo: switchContainer.centerYAnchor),

            secondPosicion.trailingAnchor.constraint(equalTo: switchContainer.trailingAnchor, constant: -27),
            secondPosicion.centerYAnchor.constraint(equalTo: switchContainer.centerYAnchor),

            switchContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            switchContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            switchContainer.widthAnchor.constraint(equalToConstant: 135),
            switchContainer.heightAnchor.constraint(equalToConstant: 45),

            switchButton.centerYAnchor.constraint(equalTo: switchContainer.centerYAnchor),
            switchButton.widthAnchor.constraint(equalToConstant: 60),
            switchButton.heightAnchor.constraint(equalToConstant: 40),
            switchButtonLeadingConstraint
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Обновляем начальное положение кнопки после компоновки
        switchButtonLeadingConstraint.constant = isSwitchOn
            ? switchContainer.frame.width - switchButton.frame.width - 5
            : 5
    }
}


