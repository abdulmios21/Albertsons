//
//  AcronymLookupTableViewController.swift
//  Albertsons Challenge
//
//  Created by Abdul Moid Mohammed on 8/2/22.
//

import UIKit

class AcronymLookupTableViewController: UITableViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    private var viewModel = AcronymLookupViewModel()
    
    var tableModels: [String] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Acronym Meaning Lookup"
        searchBar.delegate = self
        activityIndicator.isHidden = true
    }
    
    private func getMeaning(for acronym: String) {
        viewModel.findMeaningForAcronym(acronym) { [weak self] result in
            self?.stopAnimating()
            switch result {
            case .success(let models):
                self?.tableModels = models
            case .failure(let error):
                self?.tableModels = []
                self?.displayErrorAlert(error)
            }
        }
    }
    
    private func stopAnimating() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator?.stopAnimating()
        }
    }
    
    private func displayErrorAlert(_ error: Error) {
        let alert = UIAlertController(title: "Oops something went wrong", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AcronymMeaningCell.reuseIdentifier, for: indexPath) as? AcronymMeaningCell else {
            return UITableViewCell()
        }
        
        if let meaning = tableModels[safe: indexPath.row] {
            cell.update(with: meaning)
            return cell
        }
        
        return UITableViewCell()
    }
}

extension AcronymLookupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return }
        activityIndicator.isHidden = false
        activityIndicator?.startAnimating()
        getMeaning(for: searchText)
    }
}
