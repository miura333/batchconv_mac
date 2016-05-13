//
//  convCore.h
//  batchconv_mac
//
//  Created by miura on 2016/05/13.
//  Copyright © 2016年 miura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface convCore : NSObject

+ (void)convImage:(NSString *)path output_path:(NSString *)otuput_path ratio:(double)ratio;

@end
