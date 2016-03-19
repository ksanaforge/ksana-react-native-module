	// CalendarManager.m
#include "kfs_rct.h"
#include "kfs_ios.h"
@implementation KsanaFileSystem
RCT_EXPORT_MODULE();

kfs_ios *kfs;
RCT_EXPORT_METHOD(addEvent:(NSString *)name location:(NSString *)location)
{
    //RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
}

-(boolean_t) copyFile:(NSURL*)source target:(NSString*)targetFile {
    NSError *error = nil;
    NSFileManager *fm=[NSFileManager defaultManager];
    
    boolean_t copied=false;
    NSURL *targetURL=[NSURL fileURLWithPath:targetFile];
    
    NSString *folder=[[targetURL path] stringByDeletingLastPathComponent];
    if (![fm fileExistsAtPath:folder]) {
        if (![fm createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return 0;
        }
    }
    if ([fm fileExistsAtPath:targetFile ]) {
        [fm removeItemAtPath:targetFile error:nil];
    }if ([fm copyItemAtURL:source toURL:targetURL error:&error]) {
        copied=true;
    } else {
        NSLog(@"%@",[error localizedDescription]);
    }
    return copied;
}
RCT_EXPORT_METHOD(open:(NSString*) fn callback:(RCTResponseSenderBlock)callback) {
    NSNumber *res=[kfs open:fn];
    callback(@[res]);
    
}
RCT_EXPORT_METHOD(close:(nonnull NSNumber*) fid callback:(RCTResponseSenderBlock)callback) {
  NSNumber *res=[kfs close:fid];
  callback(@[res]);
  
}
RCT_EXPORT_METHOD(getFileSize:(nonnull NSNumber*) handle callback:(RCTResponseSenderBlock)callback) {
    NSNumber *res=[kfs getFileSize:handle];
    callback(@[res]);
    
}
RCT_EXPORT_METHOD(listKdb: (RCTResponseSenderBlock)callback)
{
  NSString *res=[kfs listKdb];
  callback(@[res]);
}
RCT_EXPORT_METHOD(listStockKdb: (RCTResponseSenderBlock)callback)
{
  NSString *res=[kfs listStockKdb];
  callback(@[res]);
}



RCT_EXPORT_METHOD(readSignature:(nonnull NSNumber*)handle pos:(nonnull NSNumber*)pos callback:(RCTResponseSenderBlock)callback) {
    NSString* res=[kfs readSignature:handle pos:pos];
    callback(@[res]);
}

RCT_EXPORT_METHOD(readInt32:(nonnull NSNumber*)handle pos:(nonnull NSNumber*)pos callback:(RCTResponseSenderBlock)callback) {
    NSNumber* res=[kfs readInt32:handle pos:pos];
    callback(@[res]);
}

RCT_EXPORT_METHOD(readUInt8:(nonnull NSNumber*)handle pos:(nonnull NSNumber*)pos callback:(RCTResponseSenderBlock)callback) {
    NSNumber* res=[kfs readUInt8:handle pos:pos];
    callback(@[res]);
}

RCT_EXPORT_METHOD(readUInt32:(nonnull NSNumber*)handle pos:(nonnull NSNumber*)pos callback:(RCTResponseSenderBlock)callback) {
    NSNumber* res=[kfs readUInt32:handle pos:pos];
    callback(@[res]);
}

RCT_EXPORT_METHOD(readUTF8String:(nonnull NSNumber*)handle pos:(nonnull NSNumber*)pos size:(nonnull NSNumber*)size callback:(RCTResponseSenderBlock)callback) {
    NSString* res=[kfs readUTF8String:handle pos:pos size:size];
    callback(@[res]);
}

RCT_EXPORT_METHOD(readULE16String:(nonnull NSNumber*)handle pos:(nonnull NSNumber*)pos size:(nonnull NSNumber*)size callback:(RCTResponseSenderBlock)callback) {
    NSString* res=[kfs readULE16String:handle pos:pos size:size];
    callback(@[res]);
}


RCT_EXPORT_METHOD(readBuf:(nonnull NSNumber*)handle pos:(nonnull NSNumber*)pos size:(nonnull NSNumber*)size callback:(RCTResponseSenderBlock)callback) {
    NSArray* res=[kfs readBuf:handle pos:pos size:size];
    callback(@[res]);
}


RCT_EXPORT_METHOD(readBuf_packedint:(nonnull NSNumber*)handle pos:(nonnull NSNumber*)pos size:(nonnull NSNumber*)size count:(nonnull NSNumber *)count reset:(nonnull NSNumber *)reset callback:(RCTResponseSenderBlock)callback) {
    NSDictionary* res=[kfs readBuf_packedint:handle pos:pos size:size count:count reset:reset];
    callback(@[res]);
}


RCT_EXPORT_METHOD(readFixedArray:(nonnull NSNumber*)handle pos:(nonnull NSNumber*)pos count:(nonnull NSNumber *)count unitsz:(nonnull NSNumber *)unitsz callback:(RCTResponseSenderBlock)callback) {
    NSArray* res=[kfs readFixedArray:handle pos:pos count:count unitsz:unitsz];
    callback(@[res]);
}



RCT_EXPORT_METHOD(readStringArray:(nonnull NSNumber*)handle pos:(nonnull NSNumber*)pos size:(nonnull NSNumber*)size enc:(NSString *)enc callback:(RCTResponseSenderBlock)callback) {
    NSString* res=[kfs readStringArray:handle pos:pos size:size enc:enc];
    callback(@[res]);
}



RCT_EXPORT_METHOD(mergePostings:(nonnull NSNumber*)handle positions:(NSArray*)positions callback:(RCTResponseSenderBlock)callback) {
    NSString* res=[kfs mergePostings:handle  positions:positions];
    callback(@[res]);
}

- (NSDictionary*) constantsToExport {
    return @{ @"async":@true };
}

- (NSString *)getPathForDirectory:(int)directory
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
  return [paths firstObject];
}
RCT_EXPORT_METHOD(kdbExists:(NSString*)filename callback:(RCTResponseSenderBlock)callback) {
    NSFileManager *fm=[NSFileManager defaultManager];
  
  NSString *targetPath=[self getPathForDirectory:NSCachesDirectory];
  NSString *fn = [NSString stringWithFormat:@"%@/%@.kdb", targetPath, filename];
  
  BOOL exists=[fm fileExistsAtPath:fn];
  NSNumber *n=[NSNumber numberWithBool:exists];
    callback(@[n]);
}
RCT_EXPORT_METHOD(download:(NSString *)source targetPath:(NSString *)targetPath callback:(RCTResponseSenderBlock)callback) {
    NSURL *URL = [NSURL URLWithString:source];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSession *session = [NSURLSession sharedSession];
    
    if ([targetPath isEqualToString:@""]) targetPath=[self getPathForDirectory:NSCachesDirectory];

    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request
                                                            completionHandler:
                                              ^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                  if (!error) {
                                                      NSURL *targetDirectoryURL = [NSURL fileURLWithPath:targetPath];
                                                      NSURL *targetURL = [targetDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
                                                      [[NSFileManager defaultManager] moveItemAtURL:location
                                                                                              toURL:targetURL
                                                                                              error:nil];
                                                      callback(@[[NSNull null], targetURL.absoluteString]);
                                                  } else {
                                                      NSLog(@"%@", [error description]);
                                                      callback(@[[error description]]);
                                                  }
                                              }
                                              ];
    
    [downloadTask resume];
}

- (id) init
{
    self = [super init];
    kfs= [[kfs_ios alloc] init];
    return self;
}

@end