//
//  ActivityView.h
//  Smile_100
//
//  Created by Faker on 2018/2/20.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityView : UIView
@property (nonatomic, copy) void(^didClickActiviewBlock)() ;

- (void)show;

@end
