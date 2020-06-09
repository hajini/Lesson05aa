//
//  ViewController.swift
//  Lesson05a
//
//  Created by Hajin Jeong on 2020/06/08.
//  Copyright © 2020 AmazingHajin. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView01: UITableView!
    private let apiLink = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=970d4c03f2b34285b4daf6e4293e4440"
    
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getLatest()
    }

    
    func imageIsNullOrNot(imageName : UIImage)-> Bool
    {

       let size = CGSize(width: 0, height: 0)
       if (imageName.size.width == size.width)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    func getLatest() {
        guard let articleURL = URL(string: apiLink) else {
            return
        }
        let request = URLRequest(url: articleURL)
        //Network 시작
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if err != nil {
                print(err?.localizedDescription)
                return
            }
            if data != nil {
                
                self.articles = self.parsingJsonData(data: data!)
                
                OperationQueue.main.addOperation {
                    self.tableView01.reloadData()
                }
                
            }
            
            
        }.resume()
        
    }
    
    func parsingJsonData(data: Data) -> [Article] {
        
        self.articles = [Article]()
        
            do {
               let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary

                let jsonLoans = jsonResult?["articles"] as! [AnyObject]
                for jsonLoan in jsonLoans {
                    var loan = Article()
                    
//                    loan.title = jsonLoan["title"] as! String
//                    loan.author = jsonLoan["author"] as! String
//                    loan.description = jsonLoan["description"] as! String
//                    loan.publishedAt = jsonLoan["publishedAt"] as! String
//                    loan.urlToImage = jsonLoan["urlToImage"] as! String
//                    articles.append(loan)
                
//                    guard articleToDisplay!.urlToImage != nil else {
//                        return
//                    }
                    
                    if (jsonLoan["title"] as? String) != nil {
                        loan.title = jsonLoan["title"] as! String
                    } else {
                        loan.title = "정보없음"
                    }

                    if (jsonLoan["author"] as? String) != nil {
                        loan.author = jsonLoan["author"] as! String
                    } else {
                        loan.author = "정보없음"
                    }

                    if (jsonLoan["description"] as? String) != nil {
                        loan.description = jsonLoan["description"] as! String
                    } else {
                        loan.description = "정보없음"
                    }

                    if (jsonLoan["publishedAt"] as? String) != nil {
                        loan.publishedAt = jsonLoan["publishedAt"] as! String
                    } else {
                        loan.publishedAt = "정보없음"
                    }

                    if (jsonLoan["urlToImage"] as? String) != nil {
                        loan.urlToImage = jsonLoan["urlToImage"] as! String
                    } else {
                        loan.urlToImage = "정보없음"
                    }
                    
                    articles.append(loan)
//                    print(articles)
                }
           

               } catch {
                   print(error)
               }
        
        
        return articles
    }
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "선택완료", message: "이동할까요?", preferredStyle: .alert)
        let alertAct01 = UIAlertAction(title: "확인", style: .default) { (_) in
            print("이동완료")
        }
        let alertAct02 = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(alertAct01)
        alert.addAction(alertAct02)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAct = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, handler) in
            print("Delete")
            handler(true)
        }
        addAct.backgroundColor = .red
        addAct.image = UIImage(systemName: "trash")
        
        let swipeConf = UISwipeActionsConfiguration(actions: [addAct])
        
        return swipeConf
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView01.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! Cell1
        
        cell1.label01.text = articles[indexPath.row].publishedAt
        cell1.label02.text = articles[indexPath.row].author
        cell1.label03.text = articles[indexPath.row].description
        cell1.label04.text = articles[indexPath.row].title
        
//        if imageIsNullOrNot(imageName: UIImage(named: articles[indexPath.row].urlToImage)!) {
        cell1.img01.kf.setImage(with: URL(string: articles[indexPath.row].urlToImage))
//        } else {
//            cell1.img01.image = UIImage(named: "Image")
//        }
        
        return cell1
    }
    
    
    
}
