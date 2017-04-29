/*╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
  ║ FeedViewController.swift                                                                 TV-RSS ║
  ║                                                                                                  ║
  ║ Created by Gavin Eadie on Jan03/16.           Copyright © 2016 Gavin Eadie. All rights reserved. ║
  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝*/

import UIKit

class FeedViewController: UITableViewController {

    var     feedEngine = FeedEngine()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib.init(nibName: "ItemView", bundle: nil),
                                forCellReuseIdentifier: "ItemCell")
        self.tableView.rowHeight = 120

    }

/*┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  ┃ Data Source ..                                                                                   ┃
  ┃     'callbacks' to satisfy UITableViewDataSource                                                 ┃
  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return min(feedEngine.feedItems.count, 20)

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath as IndexPath)

        cell.textLabel!.text = feedEngine.feedItems[indexPath.row].itemTitle
        cell.detailTextLabel!.text = feedEngine.feedItems[indexPath.row].itemWords

        return cell

    }


    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return feedEngine.feedTitle

    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {

        return nil

    }

/*┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  ┃ Delegate    ..                                                                                   ┃
  ┃     'callbacks' to satisfy UITableViewDelegate                                                   ┃
  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛*/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("story: \(feedEngine.feedItems[indexPath.row].itemStory)")

    }

}
