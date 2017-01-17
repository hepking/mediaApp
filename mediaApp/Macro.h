//
//  Macro.h
//  mediaApp
//
//  Created by hpking　 on 2017/1/17.
//  Copyright © 2017年 hpking　. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

#endif /* Macro_h */
