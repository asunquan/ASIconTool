//
//  ViewController.m
//  IconTool
//
//  Created by 孙泉 on 2018/1/3.
//  Copyright © 2018年 asunquan. All rights reserved.
//

#import "ViewController.h"
#import "ASIconSize.h"
#import "NSImage+ASScale.h"

@interface ViewController ()

@property (weak) IBOutlet NSImageView *sourceImageView;

@property (weak) IBOutlet NSButton *iOSButton;

@property (weak) IBOutlet NSButton *macOSButton;

@property (weak) IBOutlet NSButton *watchOSButton;

@property (weak) IBOutlet NSButton *messageButton;

@property (weak) IBOutlet NSButton *selectButton;

@property (weak) IBOutlet NSButton *generateButton;

@property (nonatomic, strong) NSString *savePath;

@property (nonatomic, strong) NSProgressIndicator *hudIndicator;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillLayout
{
    [super viewWillLayout];
    
    [self layoutHUDIndicator];
}

#pragma mark - getter

- (NSProgressIndicator *)hudIndicator
{
    if (!_hudIndicator) {
        _hudIndicator = NSProgressIndicator.new;
        _hudIndicator.style = NSProgressIndicatorStyleBar;
        _hudIndicator.controlSize = NSControlSizeRegular;
    }
    return _hudIndicator;
}

#pragma mark - method

- (void)layoutHUDIndicator
{
    self.hudIndicator.frame = CGRectMake(0, -5, 500, 200);
    [self.hudIndicator sizeToFit];
}

- (void)showHUDIndicator
{
    for (NSView *view in self.view.subviews) {
        view.hidden = YES;
    }
    
    [self.view.window.contentView addSubview:self.hudIndicator];
    [self.hudIndicator startAnimation:nil];
}

- (void)removeHUDIndicator
{
    for (NSView *view in self.view.subviews) {
        view.hidden = NO;
    }
    
    [self.hudIndicator stopAnimation:nil];
    [self.hudIndicator removeFromSuperview];
}

#pragma mark - action

- (IBAction)selectAction:(id)sender
{
    NSOpenPanel *panel = NSOpenPanel.openPanel;
    panel.allowsMultipleSelection = NO;
    panel.allowedFileTypes = @[@"png", @"jpg", @"jpeg"];
    panel.prompt = @"选择";
    
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result) {
        if (result == NSModalResponseOK) {
            [self showSourceImage:panel.URL];
        }
    }];
}

- (void)showSourceImage:(NSURL *)url
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSImage *image = [[NSImage alloc] initWithData:data];
    NSImageRep *imageRep = image.representations.firstObject;
    
    if (imageRep.hasAlpha) {
        [self showContainAlpha];
        return;
    }
    
    if (image.size.width != 1024.f || image.size.height != 1024.f) {
        [self showInvalidSize:image.size];
        return;
    }
    
    self.sourceImageView.image = image;
}

- (IBAction)generateAction:(id)sender
{
    if (!self.iOSButton.state && !self.macOSButton.state && !self.watchOSButton.state && !self.messageButton.state) {
        [self showMissingType];
        return;
    }
    
    if (!self.sourceImageView.image) {
        [self showMissingIcon];
        return;
    }
    
    NSDateFormatter *formatter = NSDateFormatter.new;
    formatter.dateFormat = @"YYYY-MM-dd HH-mm-ss";
    NSString *time = [formatter stringFromDate:NSDate.date];
    NSString *fieldName = [NSString stringWithFormat:@"Icons %@", time];
    
    NSSavePanel *panel = NSSavePanel.savePanel;
    panel.canCreateDirectories = YES;
    panel.title = @"选择路径";
    panel.prompt = @"选择并生成";
    panel.message = @"选择生成图标保存路径";
    panel.nameFieldLabel = @"文件夹";
    panel.nameFieldStringValue = fieldName;
    [panel beginWithCompletionHandler:^(NSModalResponse result) {
        if (result != NSModalResponseOK) {
            return;
        }
        
        [self showHUDIndicator];
        
        [self createDirectory:panel.URL];
        
        [self generateIOSIcon];
        
        [self generateMacOSIcon];
        
        [self generateWatchOSIcon];
        
        [self generateMessageIcon];
        
        [self showSuccess];
    }];
}

- (void)createDirectory:(NSURL *)url
{
    NSMutableArray *paths = [NSMutableArray array];
    
    self.savePath = url.absoluteString;
    
    if (self.iOSButton.state) {
        NSURL *path = [NSURL URLWithString:[url.absoluteString stringByAppendingPathComponent:@"iOS"]];
        
        [paths addObject:path];
    }
    
    if (self.macOSButton.state) {
        NSURL *path = [NSURL URLWithString:[url.absoluteString stringByAppendingPathComponent:@"macOS"]];
        
        [paths addObject:path];
    }
    
    if (self.watchOSButton.state) {
        NSURL *path = [NSURL URLWithString:[url.absoluteString stringByAppendingPathComponent:@"watchOS"]];
        
        [paths addObject:path];
    }
    
    if (self.messageButton.state) {
        NSURL *path = [NSURL URLWithString:[url.absoluteString stringByAppendingPathComponent:@"message"]];
        
        [paths addObject:path];
    }
    
    NSFileManager *fileManager = NSFileManager.defaultManager;
    
    for (NSURL *path in paths) {
        [fileManager createDirectoryAtURL:path
              withIntermediateDirectories:YES
                               attributes:nil
                                    error:nil];
    }
}

#pragma mark - 生成图标

- (void)generateIOSIcon
{
    if (!self.iOSButton.state) {
        return;
    }
    
    for (NSDictionary *dic in ASIconSize.iOSIconSizes) {
        NSString *name = dic.allKeys.firstObject;
        NSArray *sizeArray = [dic[name] componentsSeparatedByString:@"*"];
        CGFloat width = [sizeArray.firstObject floatValue];
        CGFloat height = [sizeArray.lastObject floatValue];
        CGSize size = CGSizeMake(width, height);
        
        [self generateIcon:name
                      size:size
                      path:@"iOS"];
    }
}

- (void)generateMacOSIcon
{
    if (!self.macOSButton.state) {
        return;
    }
    
    for (NSDictionary *dic in ASIconSize.macOSIconSizes) {
        NSString *name = dic.allKeys.firstObject;
        NSArray *sizeArray = [dic[name] componentsSeparatedByString:@"*"];
        CGFloat width = [sizeArray.firstObject floatValue];
        CGFloat height = [sizeArray.lastObject floatValue];
        CGSize size = CGSizeMake(width, height);
        
        [self generateIcon:name
                      size:size
                      path:@"macOS"];
    }
}

- (void)generateWatchOSIcon
{
    if (!self.watchOSButton.state) {
        return;
    }
    
    for (NSDictionary *dic in ASIconSize.watchOSIconSizes) {
        NSString *name = dic.allKeys.firstObject;
        NSArray *sizeArray = [dic[name] componentsSeparatedByString:@"*"];
        CGFloat width = [sizeArray.firstObject floatValue];
        CGFloat height = [sizeArray.lastObject floatValue];
        CGSize size = CGSizeMake(width, height);
        
        [self generateIcon:name
                      size:size
                      path:@"watchOS"];
    }
}

- (void)generateMessageIcon
{
    if (!self.messageButton.state) {
        return;
    }
    
    for (NSDictionary *dic in ASIconSize.messageIconSizes) {
        NSString *name = dic.allKeys.firstObject;
        NSArray *sizeArray = [dic[name] componentsSeparatedByString:@"*"];
        CGFloat width = [sizeArray.firstObject floatValue];
        CGFloat height = [sizeArray.lastObject floatValue];
        CGSize size = CGSizeMake(width, height);
        
        [self generateIcon:name
                      size:size
                      path:@"message"];
    }
}

- (void)generateIcon:(NSString *)name
                size:(CGSize)size
                path:(NSString *)path
{
    NSURL *saveURL = [NSURL URLWithString:[[self.savePath stringByAppendingPathComponent:path] stringByAppendingPathComponent:name]];
    
    NSImage *image = [self.sourceImageView.image as_scale:size];
    
    NSData *imageData = [image TIFFRepresentationUsingCompression:NSTIFFCompressionJPEG factor:1];
    
    [imageData writeToURL:saveURL atomically:YES];
}

#pragma mark - Alert

- (void)showContainAlpha
{
    NSAlert *alert = NSAlert.new;
    alert.alertStyle = NSAlertStyleWarning;
    alert.messageText = @"源图标透明度错误";
    alert.informativeText = @"需要提供不含透明度的源图标";
    [alert addButtonWithTitle:@"重新选择"];
    [alert addButtonWithTitle:@"取消"];
    [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertFirstButtonReturn) {
            [self selectAction:nil];
        }
    }];
}

- (void)showInvalidSize:(CGSize)size
{
    NSAlert *alert = NSAlert.new;
    alert.alertStyle = NSAlertStyleWarning;
    alert.messageText = @"源图标尺寸错误";
    alert.informativeText = [NSString stringWithFormat:@"需要提供1024*1024尺寸, 您提供的尺寸为%d*%d", (int)size.width, (int)size.height];
    [alert addButtonWithTitle:@"重新选择"];
    [alert addButtonWithTitle:@"取消"];
    [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
         if (returnCode == NSAlertFirstButtonReturn) {
             [self selectAction:nil];
         }
     }];
}

- (void)showMissingType
{
    NSAlert *alert = NSAlert.new;
    alert.alertStyle = NSAlertStyleWarning;
    alert.messageText = @"生成图标类型错误";
    alert.informativeText = @"需要选择: iOS App, macOS App, watchOS App中的一种或多种";
    [alert addButtonWithTitle:@"重新选择"];
    [alert beginSheetModalForWindow:self.view.window completionHandler:nil];
}

- (void)showMissingIcon
{
    NSAlert *alert = NSAlert.new;
    alert.alertStyle = NSAlertStyleWarning;
    alert.messageText = @"源图标选择错误";
    alert.informativeText = @"需要提供1024*1024尺寸的源图标";
    [alert addButtonWithTitle:@"重新选择"];
    [alert beginSheetModalForWindow:self.view.window completionHandler:nil];
}

- (void)showSuccess
{
    NSAlert *alert = NSAlert.new;
    alert.alertStyle = NSAlertStyleInformational;
    alert.messageText = @"图标已成功生成";
    [alert addButtonWithTitle:@"确定"];
    [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertFirstButtonReturn) {
            [self removeHUDIndicator];
        }
    }];
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
