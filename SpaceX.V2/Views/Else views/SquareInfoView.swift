import UIKit

final class SquareInfoView: UIView {

    private let titleToView: UILabel
    private let subtitleToView: UILabel
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    init(titleText: String, subtitleText: String) {
        self.titleToView = UILabel()
        self.subtitleToView = UILabel()
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        setupTitleView(titleText: titleText)
        setupSubtitleView(subtitleText: subtitleText)
        
        self.layer.cornerRadius = 24
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "infoButtonColor")
        
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }

    private func setupTitleView(titleText: String) {
        titleToView.text = titleText
        titleToView.textColor = .white
        titleToView.font = UIFont.boldSystemFont(ofSize: 18)
        titleToView.textAlignment = .center
        titleToView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupSubtitleView(subtitleText: String) {
        subtitleToView.text = subtitleText
        subtitleToView.textColor = .systemGray
        subtitleToView.font = UIFont.systemFont(ofSize: 12)
        subtitleToView.textAlignment = .center
        subtitleToView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleToView)
        stackView.addArrangedSubview(subtitleToView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
