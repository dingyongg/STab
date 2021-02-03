

import UIKit

class FSPersonalCenterTVC: UIViewController {

    var segment:FSPersonalCenterSegment?
    lazy var segmentV: UIView = {
        
        let c = UIView.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: 70 ))
        c.backgroundColor = .white
        let path = UIBezierPath.init(roundedRect: c.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.topLeft], cornerRadii: CGSize.init(width: 12.0, height: 12.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = c.bounds
        maskLayer.path = path.cgPath
        c.layer.mask = maskLayer
        
        let s = FSPersonalCenterSegment.init(frame: CGRect.init(x: 20, y: 15, width: c.bounds.width-40, height: c.bounds.height-30))
        s.titlesA = ["Tab1", "Tab2", "Tab3"]
        s.selectedIndex = 0
        s.delegate = self
        self.segment = s
        c.addSubview(s)
        
        return c
    }()
    
    lazy var tableView: FSPersonalCenterTV = {
        let v = FSPersonalCenterTV.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: SCREEN_HEIGHT))
        v.backgroundColor = THEME_COLOR_PURPLE
        v.delegate = self
        v.dataSource = self
        return v
    }()

    lazy var headerV: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 240))
        return v
    }()
    
    lazy var footerV: FSPersnalCenterFooterV = {
        let v = FSPersnalCenterFooterV.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: self.view.bounds.height - segmentV.bounds.height))
        v.delegate = self
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        self.tableView.tableHeaderView = self.headerV
        self.tableView.tableFooterView = self.footerV
        
        //核心代码
        FSPersonalCenterScrollerManager.shared.mainScroller = self.tableView

    }

}

extension FSPersonalCenterTVC: FSPersonalCenterSegmentDelegate, FSPersnalCenterFooterVDelegate{
    func footer(_ footer: FSPersnalCenterFooterV, didScrollTo index: Int) {
        segment?.selectedIndex = index
    }
    func segmentDidSelected(_ index: Int) {
        self.footerV.scrollTo(index, animated: true)
    }
    
}


extension FSPersonalCenterTVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.segmentV
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.tableView {
            return 70
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    //核心代码
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >=  self.headerV.bounds.height  {
            scrollView.contentOffset = CGPoint.init(x: 0, y: self.headerV.bounds.height)
            FSPersonalCenterScrollerManager.shared.disnableScroll(scrollView)
        }
    }
}


