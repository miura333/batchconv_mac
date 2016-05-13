//
//  main.m
//  batchconv_mac
//
//  Created by miura on 2016/05/13.
//  Copyright © 2016年 miura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "convCore.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        const char *hoge = argv[1];
        NSString *dir = [NSString stringWithUTF8String:hoge];
        const char *ratio_a = argv[2];
        double ratio = atof(ratio_a);
        
        NSError *error = nil;
        NSArray *array1 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:&error];
        if(error != nil) {
            NSLog(@"an error occured %@", [error localizedDescription]);
            return 0;
        }
        
        NSMutableArray *array2 = [[NSMutableArray alloc] initWithCapacity:1];
        int i = 0;
        for(i = 0; i < [array1 count]; i++) {
            NSString *content = [array1 objectAtIndex:i];
            if ([content hasSuffix:@".png"]) {
                [array2 addObject:content];
            }
        }
        
        //create directory
        NSString *output_dir = [dir stringByAppendingPathComponent:@"output"];
        [[NSFileManager defaultManager] createDirectoryAtPath:output_dir withIntermediateDirectories:YES attributes:nil error:&error];
        
        for(i = 0; i < [array2 count]; i++) {
            NSString *fileName = [array2 objectAtIndex:i];
            NSString *path = [dir stringByAppendingPathComponent:fileName];
            NSString *output_path = [output_dir stringByAppendingPathComponent:fileName];
            [convCore convImage:path output_path:output_path ratio:ratio];
        }
    }
    return 0;
}
