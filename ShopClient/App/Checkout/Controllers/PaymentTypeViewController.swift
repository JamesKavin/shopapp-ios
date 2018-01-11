//
//  PaymentTypeViewController.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 12/29/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import UIKit

class PaymentTypeViewController: BaseViewController<PaymentTypeViewModel>, PaymentTypeTableCellProtocol {
    @IBOutlet weak var tableView: UITableView!
    
    private var tableDataSource: PaymentTypeDataSource!
    private var destinationTitle: String!
    var completion: CreditCardPaymentCompletion?
    
    override func viewDidLoad() {
        viewModel = PaymentTypeViewModel()
        super.viewDidLoad()

        setupViews()
        setupTableView()
    }
    
    private func setupViews() {
        title = "ControllerTitle.PaymentType".localizable
    }
    
    private func setupTableView() {
        let cellNib = UINib(nibName: String(describing: PaymentTypeTableCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: String(describing: PaymentTypeTableCell.self))
        
        tableDataSource = PaymentTypeDataSource(with: self)
        tableView.dataSource = tableDataSource
    }
    
    // MARK: - PaymentTypeTableCellProtocol
    func didSelectCreditCartPayment() {
        performSegue(withIdentifier: SegueIdentifiers.toAddressList, sender: self)
    }
    
    // MARK: - segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addressListViewController = segue.destination as? AddressListViewController {
            addressListViewController.title = "ControllerTitle.BillingAddress".localizable
            addressListViewController.addressListType = .billing
            addressListViewController.destinationCreditCardCompletion = completion
        }
    }
}
