//
//  NotificationDefine.h
//  WEXWineMall
//
//  Created by K on 2017/7/24.
//  Copyright © 2017年 K. All rights reserved.
//

#ifndef NotificationDefine_h
#define NotificationDefine_h


#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

#define KNotificationLoginStateChange @"loginStateChange"

#define KNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"

#define kNotificationAddrChange         @"kNotificationAddrChange"

#define KNotificationMessageIsRead      @"messageIsRead"

#endif /* NotificationDefine_h */
