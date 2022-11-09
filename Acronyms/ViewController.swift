//
//  ViewController.swift
//  Acronyms
//
//  Created by Javad Mammadbayli on 11/9/22.
//

import UIKit

class ViewController: UIViewController {
    let reuseIdentifier = "requse"
    
    var viewModel: SearchAcronymsViewControllerViewModel!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 60)))
        searchBar.delegate = self
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
        setupUI()
        
        viewModel.getLongForms(forAcronym: "ssf")
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupUI() {
        
        tableView.tableHeaderView = searchBar
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func bind() {
        viewModel.longForms.bind {[weak self] longForms in
            self?.updateUI()
        }
    }
    
    init(viewModel: SearchAcronymsViewControllerViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.longForms.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = viewModel.longForms.value[indexPath.row].longForm
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getLongForms(forAcronym: searchText)
    }
}

