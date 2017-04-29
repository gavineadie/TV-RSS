/*╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
  ║ MainViewController.swift                                                                 TV-RSS ║
  ║                                                                                                  ║
  ║ Created by Gavin Eadie on Jan02/16.           Copyright © 2016 Gavin Eadie. All rights reserved. ║
  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝*/

import UIKit

class MainViewController: UIViewController {

    var     feedViewControllers = [FeedViewController]()
    var     feedEngines = [FeedEngine]()

    var     feedLinks: [String] {
        get {
            return ["https://feeds.bbci.co.uk/news/world/us_and_canada/rss.xml",
                    "https://www.nytimes.com/services/xml/rss/nyt/WeekinReview.xml",
                    "https://rss.support.apple.com/iphone",
                    "https://feeds.bbci.co.uk/news/scotland/rss.xml"]
        }
    }

/*┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  ┃ Setup .. in "viewDidLoad"                                                                        ┃
  ┃ -- create four feeds (FeedEngine), one each for four scrolls                                     ┃
  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛*/

    override func viewDidLoad() {
        super.viewDidLoad()

/*┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
  │ For now, there only four FeedTableViews .. they should be setup from the StoryBoard by now ..    │
  └──────────────────────────────────────────────────────────────────────────────────────────────────┘*/
        feedViewControllers = self.childViewControllers as! [FeedViewController]

        for (index,feedViewController) in feedViewControllers.enumerated() {
            feedViewController.feedEngine.readFeed(feedLinks[index])
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()             // Dispose of any resources that can be recreated.
    }

/*┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  ┃ refresh the data in the feeds (like when the app wakens from background) ..                      ┃
  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛*/
    func reloadFeeds() {

        for (index,feedViewController) in feedViewControllers.enumerated() {

            feedViewController.feedEngine.zeroFeed()
            feedViewController.feedEngine.readFeed(feedLinks[index])
            
        }

    }

}
