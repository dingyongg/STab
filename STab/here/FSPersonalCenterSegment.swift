

import UIKit

@objc protocol FSPersonalCenterSegmentDelegate {
    func segmentDidSelected(_ index: Int) -> Void
}

class FSPersonalCenterSegment: UIView {
    
    weak var delegate:FSPersonalCenterSegmentDelegate?
    
    var selectedIndex: Int = 0{
        didSet{
            for sub in self.subviews {
                let seg = sub as! FSPersonalCenterSegmentB
                if seg.tag == selectedIndex {
                    seg.isEnabled = false
                }else{
                    seg.isEnabled = true
                }
            }
        }
    }
    var titlesA:[String?] = []{
        didSet{
            
            let width:CGFloat = self.bounds.width/CGFloat(titlesA.count)
            let height = self.bounds.height
            
            for i in 0..<titlesA.count {
                let b = FSPersonalCenterSegmentB.init( titlesA[i]! , frame: CGRect.init(x: CGFloat(i)*width, y: 0, width: width, height: height))
                addSubview(b)
                b.tag = i
                b.addTarget(self, action: #selector(segmentA), for: .touchUpInside)
            }
            
        }
    }
    
    @objc func segmentA(_ sender: UIButton) -> Void {
        self.selectedIndex = sender.tag
        self.delegate?.segmentDidSelected(sender.tag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.backgroundColor = COLORFROMRGB(r: 247, 248, 249, alpha: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    class FSPersonalCenterSegmentB:UIButton{
        
        override var isEnabled: Bool{
            didSet{
                if isEnabled {
                    self.backgroundColor = .clear
                }else{
                    self.backgroundColor = THEME_COLOR_PURPLE
                }
            }
        }
        
        init(_ title: String, frame: CGRect) {
            super.init(frame: frame)
            setTitleColor(.white, for: .disabled)
            setTitleColor(.black, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: 17)
            setTitle(title, for: .normal)
        }

        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }
    

}
