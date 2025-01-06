import UIKit

final class RocketLaunchButton: UIButton {
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "infoButtonColor")
        self.layer.cornerRadius = 10

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let labelOfButton: UILabel = {
        let label = UILabel()
        label.text = "Посмотреть запуски"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageRocket: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Rocket")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 50)
    }
    
    private func setupUI() {
        [labelOfButton, imageRocket].forEach{ self.addSubview($0) }
        
        NSLayoutConstraint.activate([
            labelOfButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -10),
            labelOfButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            imageRocket.widthAnchor.constraint(equalToConstant: 30),
            imageRocket.heightAnchor.constraint(equalToConstant: 30),
            imageRocket.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageRocket.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
}
