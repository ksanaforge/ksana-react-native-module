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

RCT_EXPORT_METHOD(getFileSize:(NSNumber*) handle callback:(RCTResponseSenderBlock)callback) {
    NSNumber *res=[kfs getFileSize:handle];
    callback(@[res]);
    
}
RCT_EXPORT_METHOD(listApps: (RCTResponseSenderBlock)callback)
{
    NSString *res=[kfs listApps];
    callback(@[res]);
    
}



RCT_EXPORT_METHOD(readSignature:(NSNumber*)handle pos:(NSNumber*)pos callback:(RCTResponseSenderBlock)callback) {
    NSString* res=[kfs readSignature:handle pos:pos];
    callback(@[res]);
}

RCT_EXPORT_METHOD(readInt32:(NSNumber*)handle pos:(NSNumber*)pos callback:(RCTResponseSenderBlock)callback) {
    NSNumber* res=[kfs readInt32:handle pos:pos];
    callback(@[res]);
}

RCT_EXPORT_METHOD(readUInt8:(NSNumber*)handle pos:(NSNumber*)pos callback:(RCTResponseSenderBlock)callback) {
    NSNumber* res=[kfs readUInt8:handle pos:pos];
    callback(@[res]);
}

RCT_EXPORT_METHOD(readUInt32:(NSNumber*)handle pos:(NSNumber*)pos callback:(RCTResponseSenderBlock)callback) {
    NSNumber* res=[kfs readUInt32:handle pos:pos];
    callback(@[res]);
}

RCT_EXPORT_METHOD(readUTF8String:(NSNumber*)handle pos:(NSNumber*)pos size:(NSNumber*)size callback:(RCTResponseSenderBlock)callback) {
    NSString* res=[kfs readUTF8String:handle pos:pos size:size];
    callback(@[res]);
}

RCT_EXPORT_METHOD(readULE16String:(NSNumber*)handle pos:(NSNumber*)pos size:(NSNumber*)size callback:(RCTResponseSenderBlock)callback) {
    NSString* res=[kfs readULE16String:handle pos:pos size:size];
    callback(@[res]);
}


RCT_EXPORT_METHOD(readBuf:(NSNumber*)handle pos:(NSNumber*)pos size:(NSNumber*)size callback:(RCTResponseSenderBlock)callback) {
    NSArray* res=[kfs readBuf:handle pos:pos size:size];
    callback(@[res]);
}


RCT_EXPORT_METHOD(readBuf_packedint:(NSNumber*)handle pos:(NSNumber*)pos size:(NSNumber*)size count:(NSNumber *)count reset:(NSNumber *)reset callback:(RCTResponseSenderBlock)callback) {
    NSDictionary* res=[kfs readBuf_packedint:handle pos:pos size:size count:count reset:reset];
    callback(@[res]);
}


RCT_EXPORT_METHOD(readFixedArray:(NSNumber*)handle pos:(NSNumber*)pos count:(NSNumber *)count unitsz:(NSNumber *)unitsz callback:(RCTResponseSenderBlock)callback) {
    NSArray* res=[kfs readFixedArray:handle pos:pos count:count unitsz:unitsz];
    callback(@[res]);
}



RCT_EXPORT_METHOD(readStringArray:(NSNumber*)handle pos:(NSNumber*)pos size:(NSNumber*)size enc:(NSString *)enc callback:(RCTResponseSenderBlock)callback) {
    NSString* res=[kfs readStringArray:handle pos:pos size:size enc:enc];
    callback(@[res]);
}



RCT_EXPORT_METHOD(mergePostings:(NSNumber*)handle positions:(NSArray*)positions callback:(RCTResponseSenderBlock)callback) {
    NSString* res=[kfs mergePostings:handle  positions:positions];
    callback(@[res]);
}

- (NSDictionary*) constantsToExport {
    return @{ @"async":@true };
}

- (id) init
{
    self = [super init];
    kfs= [[kfs_ios alloc] init];
    return self;
}

@end