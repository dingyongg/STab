

import UIKit

// 核心类
class FSPersonalCenterTV: UITableView, UIGestureRecognizerDelegate {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var lastContentOffset:CGPoint = .zero
    var canScroll:Bool = true
    override var contentOffset: CGPoint{
        didSet{
            if canScroll {
                lastContentOffset = contentOffset
            }else{
                
                if lastContentOffset != contentOffset {
                    contentOffset = lastContentOffset
                }
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if otherGestureRecognizer.view is FSPersonalCenterFooterContainer {
            return false
        }
        return true
    }
}

