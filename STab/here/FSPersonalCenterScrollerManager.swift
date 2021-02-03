

import UIKit

class FSPersonalCenterScrollerManager {

    weak var mainScroller:FSPersonalCenterTV?
    weak var viceScroller:FSPersonalCenterTV?
    
    static let shared: FSPersonalCenterScrollerManager = FSPersonalCenterScrollerManager.init()
    
    func disnableScroll(_ scroller: UIScrollView) -> Void {
        if scroller is FSPersonalCenterTV {
            let fstv  = scroller as! FSPersonalCenterTV
            fstv.canScroll = false
            if fstv == mainScroller {
                viceScroller?.canScroll = true
            }else if fstv == viceScroller{
                mainScroller?.canScroll = true
            }
        }
    }

}
