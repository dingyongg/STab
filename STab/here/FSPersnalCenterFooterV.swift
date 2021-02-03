

import UIKit

@objc protocol FSPersnalCenterFooterVDelegate {
    func footer(_ footer:FSPersnalCenterFooterV, didScrollTo index: Int) -> Void
}

class FSPersnalCenterFooterV: UIView{
    
    weak var delegate:FSPersnalCenterFooterVDelegate?
    
    var children:[FSPersonalCenterTV?] = []

    
    lazy var container: FSPersonalCenterFooterContainer = {
        let sv = FSPersonalCenterFooterContainer.init(frame: self.bounds)
        sv.showsHorizontalScrollIndicator = false
        sv.delegate = self
        return sv
    }()
    
    lazy var t1: FSPersonalCenterTV = {
        let v = FSPersonalCenterTV.init(frame: self.bounds, style: .plain)
        v.dataSource = self
        v.delegate = self
        v.canScroll = false
        return v
    }()
    
    lazy var t2: FSPersonalCenterTV = {
        let v = FSPersonalCenterTV.init(frame: self.bounds, style: .plain)
        v.frame.origin.x = self.bounds.width
        v.dataSource = self
        v.delegate = self
        v.canScroll = false
        return v
    }()
    
    lazy var t3: FSPersonalCenterTV = {
        let v = FSPersonalCenterTV.init(frame: self.bounds, style: .plain)
        v.frame.origin.x = self.bounds.width*2
        v.dataSource = self
        v.delegate = self
        v.canScroll = false
        return v
    }()
    
    override init(frame: CGRect) {
       
        super.init(frame: frame)
        addSubview(container)

        container.addSubview(t1)
        container.addSubview(t2)
        container.addSubview(t3)
        
        container.contentSize = CGSize.init(width: frame.width*3, height: frame.height)
        children.append(t1)
        children.append(t2)
        children.append(t3)
        
        //核心代码
        FSPersonalCenterScrollerManager.shared.viceScroller = t1
        
    }
    
    func scrollTo(_ index: Int, animated: Bool) -> Void {
        
        let x:CGFloat = CGFloat(index) * container.bounds.width
        
        container.setContentOffset(CGPoint.init(x: x, y: 0), animated: animated)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension FSPersnalCenterFooterV: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == t1 {
            return 30
        } else if tableView == t2{
            return 10
        }else{
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "Helloworld"
        return cell!
        
    }
    
    // 核心代码
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is FSPersonalCenterTV {
            let fs = scrollView as! FSPersonalCenterTV
            if fs.contentOffset.y <= 0{
                FSPersonalCenterScrollerManager.shared.disnableScroll(scrollView)
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        if scrollView is FSPersonalCenterFooterContainer {
            let index = scrollView.contentOffset.x/self.bounds.width
            let sv = children[Int(index)]
            FSPersonalCenterScrollerManager.shared.viceScroller = sv
            self.delegate?.footer(self, didScrollTo: Int(index))
        }
    }
    
    
}

class FSPersonalCenterFooterContainer: UIScrollView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isPagingEnabled = true
        self.bounces = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

