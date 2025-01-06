import UIKit

extension RocketViewController {
    //MARK: - selectors
    
    @objc func targetForSettingButton() {
        let buttonVC = SettingsViewController()
        buttonVC.modalPresentationStyle = .pageSheet
        present(buttonVC, animated: true, completion: nil)
    }
    
    @objc func rocketViewTapped() {
        let rocketVC = LaunchesViewController(rocket: rocketName)
        navigationController?.pushViewController(rocketVC, animated: true)
    }
    
    //MARK: - animations
    
    @objc func buttonTouchDownBright() {
        UIView.animate(withDuration: 0.0, animations: {
            self.settingButton.alpha = 0.6
        })
    }

    @objc func buttonTouchUpInsideBright() {
        UIView.animate(withDuration: 0.0, animations: {
            self.settingButton.alpha = 1.0
        })
    }

    @objc func buttonTouchUpOutsideBright() {
        UIView.animate(withDuration: 0.0, animations: {
            self.settingButton.alpha = 1.0
        })
    }
    
    @objc func buttonTouchDownTransform(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    @objc func buttonTouchUpTransform(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
    }
    
    //MARK: - addTargets
    
    func addTargets() {
        settingButton.addTarget(self, action: #selector(targetForSettingButton),
                                for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(buttonTouchDownBright),
                                for: .touchDown)
        settingButton.addTarget(self, action: #selector(buttonTouchUpInsideBright),
                                for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(buttonTouchUpOutsideBright),
                                for: .touchUpOutside)
        
        rocketLaunchButton.addTarget(self, action: #selector(rocketViewTapped), for: .touchUpInside)
        rocketLaunchButton.addTarget(self, action: #selector(buttonTouchDownTransform),
                                for: .touchDown)
        rocketLaunchButton.addTarget(self, action: #selector(buttonTouchUpTransform),
                                for: .touchUpInside)
        rocketLaunchButton.addTarget(self, action: #selector(buttonTouchUpTransform),
                                for: .touchUpOutside)
    }
}
