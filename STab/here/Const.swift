

import UIKit
import Foundation


let SCREEN_BOUNDS = UIScreen.main.bounds
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let IS_IPhoneX:Bool = SCREEN_HEIGHT >= 812 ? true : false


let HAWA_STATUS_BAR_HEIGHT :CGFloat = IS_IPhoneX ? 44 : 20
let HAWA_NAVI_HEIGHT:CGFloat = IS_IPhoneX ? 88 : 64
let HAWA_BOTTOM_TAB_HEIGHT:CGFloat = IS_IPhoneX ? 83 : 49
let HAWA_CONTENT_HEIGHT:CGFloat = SCREEN_HEIGHT - HAWA_NAVI_HEIGHT - HAWA_BOTTOM_TAB_HEIGHT
let HAWA_SCREEN_HORIZATAL_SPACE :CGFloat = 12
let BOTTOM_HEIGHT: CGFloat = IS_IPhoneX ? 34 : 0
let SCREEN_SAFE_SPACE: CGFloat = IS_IPhoneX ? 34 : 0

func COLORFROMRGB(r:CGFloat,_ g:CGFloat,_ b:CGFloat, alpha:CGFloat) -> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: alpha)
}
let THEME_COLOR_PURPLE = COLORFROMRGB(r: 167, 103, 254, alpha: 1)
