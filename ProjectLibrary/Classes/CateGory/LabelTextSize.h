//
//  HWLabelTextSize.h
//  PersonnelRegister
//
//  Created by 江苏宏创 on 14-4-15.
//  Copyright (c) 2014年 江苏宏创. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <CoreGraphics/CGGeometry.h>


@interface LabelTextSize : NSObject
+(CGSize)getSuitSizeWithString:(NSString *)text fontSize:(float)fontSize bold:(BOOL)bold sizeOfX:(float)x;
@end
