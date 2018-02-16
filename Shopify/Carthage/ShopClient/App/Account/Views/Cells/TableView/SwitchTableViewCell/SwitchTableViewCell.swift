//
//  SwitchTableViewCell.swift
//  ShopClient
//
//  Created by Radyslav Krechet on 1/22/18.
//  Copyright © 2018 RubyGarage. All rights reserved.
//

import RxSwift

private let kSwitchControlDebounceDueTime = 0.3

protocol SwitchTableCellDelegate: class {
    func tableViewCell(_ tableViewCell: SwitchTableViewCell, didChangeSwitchStateAt indexPath: IndexPath, with value: Bool)
}

class SwitchTableViewCell: UITableViewCell {
    @IBOutlet private weak var swicthDescriptionlabel: UILabel!
    @IBOutlet private weak var switchControl: UISwitch!
    
    private let disposeBag = DisposeBag()
    
    private var indexPath: IndexPath!
    
    weak var delegate: SwitchTableCellDelegate?
    
    // MARK: - View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        setupViews()
    }
    
    // MARK: - Setup
    
    func configure(with indexPath: IndexPath, description: String, state: Bool = false) {
        self.indexPath = indexPath
        swicthDescriptionlabel.text = description
        switchControl.isOn = state
    }
    
    private func setupViews() {
        let switchResults = switchControl.rx.isOn
            .debounce(kSwitchControlDebounceDueTime, scheduler: MainScheduler.instance)
            .observeOn(MainScheduler.instance)

        switchResults.asObservable()
            .skip(1)
            .subscribe(onNext: { [weak self] value in
                guard let strongSelf = self, let delegate = strongSelf.delegate else {
                    return
                }
                delegate.tableViewCell(strongSelf, didChangeSwitchStateAt: strongSelf.indexPath, with: value)
            })
            .disposed(by: disposeBag)
    }
}
