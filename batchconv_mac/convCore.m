//
//  convCore.m
//  batchconv_mac
//
//  Created by miura on 2016/05/13.
//  Copyright © 2016年 miura. All rights reserved.
//

#import "convCore.h"

@import AppKit;

@implementation convCore

+ (void)convImage:(NSString *)path output_path:(NSString *)output_path ratio:(double)ratio {
    NSImage* image = [[NSImage alloc] initWithContentsOfFile:path];
    NSSize image_size = [image size];
    
    NSSize new_image_size;
    new_image_size.width = (int)(image_size.width * ratio);
    new_image_size.height = (int)(image_size.height * ratio);
 
    NSRect image_rect = NSMakeRect(0.0, 0.0, image_size.width, image_size.height);
    NSRect new_image_rect = NSMakeRect(0.0, 0.0, new_image_size.width, new_image_size.height);
    
    NSBitmapImageRep *rep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
                                                                    pixelsWide:new_image_size.width
                                                                    pixelsHigh:new_image_size.height
                                                                 bitsPerSample:8
                                                               samplesPerPixel:4
                                                                      hasAlpha:YES
                                                                      isPlanar:NO
                                                                colorSpaceName:NSDeviceRGBColorSpace
                                                                   bytesPerRow:4 * new_image_size.width
                                                                  bitsPerPixel:32];
    NSGraphicsContext *g = [NSGraphicsContext graphicsContextWithBitmapImageRep:rep];
    CGContextRef context = [g graphicsPort];
    CGImageRef cgImage = [image CGImageForProposedRect:&image_rect context:nil hints:nil];
    CGContextDrawImage(context, new_image_rect, cgImage);
    
    CGImageRef output_image = CGBitmapContextCreateImage(context);
    
    //画像保存
    //NSString* output_path = [NSHomeDirectory() stringByAppendingPathComponent:@"Desktop/hoge.png"];
    
    NSBitmapImageRep* rep2 = [[NSBitmapImageRep alloc] initWithCGImage:output_image];
    NSData* PNGData = [rep2 representationUsingType:NSPNGFileType properties:nil];
    [PNGData writeToFile:output_path atomically:NO];
    
}

@end
