package io.ksanaforge.kdb;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.GuardedAsyncTask;
import org.json.JSONArray;
import org.json.JSONException;
import java.io.*;
import android.content.res.AssetManager;
import android.content.Context;
import android.os.Environment;
import android.util.Log;
public class KFS extends ReactContextBaseJavaModule {
	public kfs_droid kfs_api=null;

  public KFS (ReactApplicationContext reactContext) {
    super(reactContext);
    kfs_api = new kfs_droid();
    File vSDCard=Environment.getExternalStorageDirectory();    
    String kdbpath= vSDCard.getPath() +"/kdb/";
    kfs_api.setPath(kdbpath);

    AssetManager am=reactContext.getAssets();
    try{
    	copyAssetKDB(am,am.list("kdb"),kdbpath);	
    } catch(final Exception e) {

    }
    
  }

  static void copyfile(InputStream in, String dst) throws IOException {
      OutputStream out = new FileOutputStream(dst);
      // Transfer bytes from in to out
      byte[] buf = new byte[1024];
      int len;
      while ((len = in.read(buf)) > 0) {
          out.write(buf, 0, len);
      }
      in.close();
      out.close();
  }
	protected void copyAssetKDB(AssetManager am,String [] files,String targetpath) throws IOException {
      final File path = new File(targetpath);
      if (!path.exists()) path.mkdirs();

      for (int i=0;i<files.length;i++) {
          InputStream input=am.open("kdb/"+files[i]);
          final File f=new File(targetpath+files[i]);
          if (!f.exists()) {
          	copyfile(input, targetpath+files[i]);
          }
      }
	}
  
  @Override
  public String getName() {
    return "KDB";
  }

@ReactMethod
	public void open(final String fname,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				callback.invoke(kfs_api.open(fname));
			}
		}.execute();
	}

@ReactMethod
	public void readInt32 (final int handle, final int pos,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				callback.invoke(new Integer(kfs_api.readInt32(handle,pos)));
			}
		}.execute();
	}
@ReactMethod
	public void readUInt32 (final int handle, final int pos,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				callback.invoke(new Integer(kfs_api.readUInt32(handle,pos)));
			}
		}.execute();
	}
@ReactMethod
	public void readUInt8 (final int handle, final int pos,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				callback.invoke(new Integer(kfs_api.readUInt8(handle,pos)));
			}
		}.execute();
	}
@ReactMethod
	public void readULE16String (final int handle, final int pos, final int sz,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				callback.invoke(kfs_api.readULE16String(handle,pos,sz));
			}
		}.execute();
	}
@ReactMethod
	public void readUTF8String (final int handle, final int pos, final int sz,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				callback.invoke(kfs_api.readUTF8String(handle,pos,sz));
			}
		}.execute();
	}
@ReactMethod
	public void readBuf (final int handle, final int pos, final int sz,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				callback.invoke(kfs_api.readBuf(handle,pos,sz));
			}
		}.execute();
	}
@ReactMethod
	public void readBuf_packedint (final int handle, final int pos,final int blocksize, final int count, final boolean reset,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				callback.invoke(kfs_api.readBuf_packedint(handle,pos,blocksize,count,reset));
			}
		}.execute();
	}
@ReactMethod
	public void readFixedArray (final int handle, final int pos, final int count, final int unitsz,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				callback.invoke(kfs_api.readFixedArray(handle,pos,count,unitsz));
			}
		}.execute();
	}
@ReactMethod
	public void readStringArray (final int handle, final int pos, final int sz, final String enc,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				callback.invoke(kfs_api.readStringArray(handle,pos,sz,enc));
			}
		}.execute();
	}
@ReactMethod
	public void mergePostings(final int handle,final String positions,final Callback callback)  throws JSONException {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				try{
					callback.invoke(kfs_api.mergePostings(handle,positions));
				} catch (JSONException e) {
          e.printStackTrace();
				}
			}
		}.execute();
	} 
@ReactMethod
	public void readDir(final String path,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				callback.invoke(kfs_api.readDir(path));
			}
		}.execute();
	}
@ReactMethod
	public void close(final int handle,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				kfs_api.close(handle);
				callback.invoke();
			}
		}.execute();
	}

@ReactMethod
	public void getFileSize(final int handle,final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				callback.invoke(new Integer(kfs_api.getFileSize(handle)));
			}
		}.execute();
	}


@ReactMethod
	public void test(final Callback callback) {
		new GuardedAsyncTask<Void, Void>(getReactApplicationContext()) {
			@Override
			protected void doInBackgroundGuarded(Void ...params) {
				/*
				try {
					mDb.close();
				} catch(Exception e) {
					FLog.w(ReactConstants.TAG, "Exception in database close: ", e);
					callback.invoke(ErrorUtil.getError(null, e.getMessage()), null);
				}
				*/
				int handle=kfs_api.open("moedict.kdb");
				callback.invoke(null,handle);
			}
		}.execute();
	}	
}