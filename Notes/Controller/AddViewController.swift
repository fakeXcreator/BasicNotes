import UIKit
import SnapKit

class AddViewController: UIViewController {
    
    // MARK: Properties
    
    private let manager = CoreManager.shared
    var note: Note?
    
    // MARK: UI Components
    
    lazy var titleField: UITextField = {
        let titleField = UITextField()
        titleField.backgroundColor = .white
        titleField.layer.cornerRadius = 8
        titleField.layer.borderWidth = 1.0
        titleField.layer.borderColor = UIColor.darkGray.cgColor
        titleField.placeholder = "Type title name..."
        titleField.text = note?.title ?? ""
        titleField.textColor = .darkGray
        titleField.font = UIFont(name: "Baskerville-Regular", size: 12)
        
        let paddingView = UIView()
        titleField.leftView = paddingView
        titleField.leftViewMode = .always
        titleField.rightView = paddingView
        titleField.rightViewMode = .always
        
        return titleField
    }()
    
    lazy var textField: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.textColor = .darkGray
        textField.font = UIFont(name: "Baskerville-Regular", size: 12)
        
        return textField
    }()
    
    private var buttonOne: UIButton!
    
    lazy var action = UIAction { _ in
        if self.note == nil {
            self.manager.addNewNote(title: self.titleField.text ?? "", text: self.textField.text)
        } else {
            self.note?.updateNote(newTitle: self.titleField.text ?? "", newText: self.textField.text)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        title = "Add Note"
        super.viewDidLoad()
        setupUI()
        configureConstraints()
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        view.addSubview(titleField)
        view.addSubview(textField)
        
        buttonOne = UIButton(primaryAction: action)
        buttonOne.setTitle("Save", for: .normal)
        buttonOne.setTitleColor(.white, for: .normal)
        buttonOne.backgroundColor = .systemBackground
        buttonOne.layer.cornerRadius = 8
        buttonOne.layer.borderColor = UIColor.systemBlue.cgColor
        buttonOne.layer.borderWidth = 1
        
        view.addSubview(buttonOne)
    }
    
    private func configureConstraints() {
        
        titleField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        titleField.leftView?.snp.makeConstraints { make in
            make.width.equalTo(10)
        }
        
        titleField.rightView?.snp.makeConstraints { make in
            make.width.equalTo(10)
        }
        
        textField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(titleField.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
        
        buttonOne.snp.makeConstraints { make in
            make.leading.equalTo(textField.snp.leading)
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
}
