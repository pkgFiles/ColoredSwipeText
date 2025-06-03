/*
 
 MIT License
 
 Copyright (c) 2025 ★ Install Package Files
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 */

import Preferences

@available(iOS 14.0, *)
class CSTSwitchPickerCell: PSTableCell, UIColorPickerViewControllerDelegate {
    
    //MARK: - Propertys
    private lazy var cellTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = traitCollection.userInterfaceStyle == .light ? UIColor.black : UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellSubtitleLabel: MarqueeLabel = {
        let label = MarqueeLabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.gray
        label.type = .leftRight
        label.animationCurve = .easeInOut
        label.animationDelay = 1.0
        label.speed = .duration(7.5) //5.0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cellColorPreviewView: UIView = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(showPickerController))
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.borderColor = self.traitCollection.userInterfaceStyle == .dark ? (UIColor.white.cgColor) : (UIColor.black.cgColor)
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 5
        view.addGestureRecognizer(recognizer)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cellColorPickerController: UIColorPickerViewController = {
        let controller = UIColorPickerViewController()
        controller.delegate = self
        controller.supportsAlpha = true
        return controller
    }()
    
    private lazy var cellSwitch: UISwitch = {
        let _switch = UISwitch()
        _switch.onTintColor = tweakColor
        _switch.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        _switch.translatesAutoresizingMaskIntoConstraints = false
        return _switch
    }()
    
    //MARK: - Variables
    private let currentSuiteName: String = "com.pkgfiles.coloredswipetextprefs"
    private let cellInsets: (top: CGFloat, bottom: CGFloat) = (10, 10)
    
    //MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String, specifier: PSSpecifier) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        guard let plistData: NSDictionary = NSDictionary(contentsOfFile: "\(plistPath)\(currentSuiteName).plist"),
              let switchKey: String = specifier.property(forKey: "switchKey") as? String,
              let switchValue: Bool = plistData.value(forKey: switchKey) as? Bool,
              let colorKey: String = specifier.property(forKey: "colorKey") as? String,
              let colorValue: String = plistData.value(forKey: colorKey) as? String else { return }
            
        cellSwitch.isOn = switchValue
        cellColorPreviewView.backgroundColor = UIColor(hex: colorValue)
        cellTitleLabel.text = specifier.property(forKey: "cellTitleLabel") as? String
        cellSubtitleLabel.text = specifier.property(forKey: "cellSubtitleLabel") as? String
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cellTitleLabel)
        self.contentView.addSubview(cellSubtitleLabel)
        self.contentView.addSubview(cellColorPreviewView)
        self.contentView.addSubview(cellSwitch)
        
        NSLayoutConstraint.activate([
            cellTitleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -7.5),
            cellTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 22.5),
            cellTitleLabel.trailingAnchor.constraint(equalTo: cellColorPreviewView.leadingAnchor, constant: -5),
            
            cellSubtitleLabel.topAnchor.constraint(equalTo: cellTitleLabel.bottomAnchor, constant: 2),
            cellSubtitleLabel.leadingAnchor.constraint(equalTo: cellTitleLabel.leadingAnchor),
            cellSubtitleLabel.trailingAnchor.constraint(equalTo: cellColorPreviewView.leadingAnchor, constant: -5),
            
            cellColorPreviewView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: cellInsets.top),
            cellColorPreviewView.trailingAnchor.constraint(equalTo: cellSwitch.leadingAnchor, constant: -10),
            cellColorPreviewView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -(cellInsets.bottom)),
            cellColorPreviewView.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -(cellInsets.top + cellInsets.bottom)),
            
            cellSwitch.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            cellSwitch.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -22.5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    @objc private func handleSwitch() {
        guard let plistData: NSDictionary = NSDictionary(contentsOfFile: "\(plistPath)\(currentSuiteName).plist") else { return }
        guard let propertyKey: String = specifier.property(forKey: "switchKey") as? String else { return }
        plistData.setValue(cellSwitch.isOn, forKey: propertyKey)
        plistData.write(toFile: "\(plistPath)\(currentSuiteName).plist", atomically: true)
    }

    @objc private func showPickerController() {
        guard let viewController = self.contentView.findViewController() else { return }
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            viewController.present(strongSelf.cellColorPickerController, animated: true)
        }
    }
    
    //MARK: - Delegate (UIColorPickerViewControllerDelegate)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        // Set the color in the previewView
        cellColorPreviewView.backgroundColor = viewController.selectedColor
        
        // Write the color to preferences
        guard let plistData: NSDictionary = NSDictionary(contentsOfFile: currentSuiteFilePath),
              let propertyKey: String = specifier.property(forKey: "colorKey") as? String,
              let hexColor = viewController.selectedColor.toHex(alpha: true) else { return }
        plistData.setValue(hexColor, forKey: propertyKey)
        plistData.write(toFile: currentSuiteFilePath, atomically: true)
    }
}
