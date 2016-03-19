#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
@import JavaScriptCore;
@protocol KFSExport <JSExport>

JSExportAs(close,            - (NSNumber *)close:(NSNumber*)handle);
JSExportAs(open,             - (NSNumber *)open:(NSString*)fn);
JSExportAs(getFileSize,      - (NSNumber *)getFileSize:(NSNumber *)handle);

JSExportAs(readSignature,    - (NSString *)readSignature:(NSNumber *)handle pos:(NSNumber *)pos);
JSExportAs(readInt32,        - (NSNumber *)readInt32:(NSNumber *)handle pos:(NSNumber *)pos);
JSExportAs(readUInt32,       - (NSNumber *)readUInt32:(NSNumber *)handle pos:(NSNumber *)pos);
JSExportAs(readUInt8,        - (NSNumber *)readUInt8:(NSNumber *)handle pos:(NSNumber *)pos);
JSExportAs(readUTF8String,   - (NSString *)readUTF8String:(NSNumber *)handle pos:(NSNumber *)pos size:(NSNumber *)size);
JSExportAs(readULE16String,  - (NSString *)readULE16String:(NSNumber *)handle pos:(NSNumber *)pos size:(NSNumber *)size);
JSExportAs(readBuf,       - (NSArray *)readBuf:(NSNumber *)handle pos:(NSNumber *)pos size:(NSNumber *)size);
JSExportAs(readBuf_packedint,- (NSDictionary *)readBuf_packedint:(NSNumber *)handle pos:(NSNumber *)pos size:(NSNumber *)size  count:(NSNumber *)count reset:(NSNumber *)reset);
JSExportAs(readFixedArray,   - (NSArray *)readFixedArray:(NSNumber *)handle pos:(NSNumber *)pos  count:(NSNumber *)count unitsz:(NSNumber *)unitsz);
JSExportAs(readStringArray,  - (NSString *)readStringArray:(NSNumber *)handle pos:(NSNumber *)pos  size:(NSNumber *)size enc:(NSString *)enc);

JSExportAs(readDir,          - (NSString*)readDir:(NSString*)path);
JSExportAs(mergePostings,    - (NSString*) mergePostings:(NSNumber*)handle positions:(NSArray*)positions);
JSExportAs(deleteApp,        - (NSNumber*)deleteApp:(NSString*)appname);

-(NSString*) listKdb;
-(NSString*) listStockKdb;


//- (void)setViewController :(UIViewController*)vc;
@end

@interface kfs_ios: NSObject <KFSExport> {
    //UIViewController *vc;
}

-(void) setRoot : (NSString*)root;
-(void) finalize ;
@end