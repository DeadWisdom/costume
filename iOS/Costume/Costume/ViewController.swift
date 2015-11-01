//
//  ViewController.swift
//  Costume
//
//  Created by Brantley Harris on 10/31/15.
//  Copyright © 2015 Brantley Harris, Inc. All rights reserved.
//

import UIKit
import AudioToolbox


class ViewController: UIViewController {
    var rolloverSeconds : NSTimeInterval = 20
    var loadSeconds : NSTimeInterval = 20
    
    var cards = [String]()
    var count : Int = 0
    var index : Int = 0
    var loadTimer = NSTimer()
    var rollTimer = NSTimer()

    @IBOutlet weak var _text: UITextField!
    
    func loadCards() {
        let endpoint = NSURL(string: "http://brantleyharris.com/cards/")
        let data = NSData(contentsOfURL: endpoint!)
        
        do {
            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                cards = []
                if let items = json["cards"] as? [String] {
                    for item in items {
                        cards.append(item)
                    }
                    
                    if (items.count > count) {
                        self.onNewCard()
                    }
                    
                    count = items.count
                }
            }
        } catch {
            cards = [
                "Sexy Syrian War",
                "Sam Waterston's Eyebrows",
                "Ravenswood Manor"
            ]
            selectCard(0)
        }
    }
    
    func selectCard(i: Int) {
        index = i
        self._text.text = self.cards[i]
    }
    
    func onNewCard() {
        //let sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("notify", ofType: "wav"))
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTimer = NSTimer.scheduledTimerWithTimeInterval(self.loadSeconds, target:self, selector: Selector("loadCards"), userInfo: nil, repeats: true)
        loadCards()
        resetRollover()
    }
    
    func resetRollover() {
        rollTimer.invalidate()
        rollTimer = NSTimer.scheduledTimerWithTimeInterval(self.rolloverSeconds, target:self, selector: Selector("onRollover"), userInfo: nil, repeats: true)
    }
    
    func onRollover() {
        let next_index = index + 1
        
        if (next_index == cards.count) {
            return;
        }
        
        self._text.fadeOut(completion: {
            (finished: Bool) -> Void in
            self.selectCard(next_index)
            self._text.fadeIn()
        })
    }

    @IBAction func onTouchPrev(sender: UIButton) {
        if (index == 0) {
            selectCard(cards.count-1)
        } else {
            selectCard(index - 1)
        }
        resetRollover();
    }
    
    @IBAction func onTouchNext(sender: UIButton) {
        if (index == cards.count - 1) {
            selectCard(0)
        } else {
            selectCard(index + 1)
        }
        resetRollover();
    }
}
