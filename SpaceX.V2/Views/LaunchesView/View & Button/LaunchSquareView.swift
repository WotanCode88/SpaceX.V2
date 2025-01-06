import UIKit

final class RocketInfoSquareView: UIView {
    
    private let title: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 22)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let subtitle: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 16)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let success: Bool
    
    init(title: String, subtitle: String, success: Bool) {
        self.title.text = title
        self.subtitle.text = subtitle
        self.success = success
        
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 22
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "infoButtonColor")
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 350, height: 100)
    }

    private lazy var rocketImageView: UIImageView = {
        let imageToView = success ? UIImage(named: "RocketGo") : UIImage(named: "RocketFail")
        let imgView = UIImageView(image: imageToView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private func setupUI() {
        [rocketImageView, stackView].forEach{ self.addSubview($0) }
        [title, subtitle].forEach{ stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            
            rocketImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rocketImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            rocketImageView.widthAnchor.constraint(equalToConstant: 45),
            rocketImageView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
