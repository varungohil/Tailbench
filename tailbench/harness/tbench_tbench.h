/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class tbench_tbench */

#ifndef _Included_tbench_tbench
#define _Included_tbench_tbench
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     tbench_tbench
 * Method:    tBenchServerInit
 * Signature: (I)V
 */
JNIEXPORT void JNICALL Java_tbench_tbench_tBenchServerInit
  (JNIEnv *, jclass, jint);

/*
 * Class:     tbench_tbench
 * Method:    tBenchServerThreadStart
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_tbench_tbench_tBenchServerThreadStart
  (JNIEnv *, jclass);

/*
 * Class:     tbench_tbench
 * Method:    tBenchServerFinish
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_tbench_tbench_tBenchServerFinish
  (JNIEnv *, jclass);

/*
 * Class:     tbench_tbench
 * Method:    tBenchRecvReq
 * Signature: ()[B
 */
JNIEXPORT jbyteArray JNICALL Java_tbench_tbench_tBenchRecvReq
  (JNIEnv *, jclass);

/*
 * Class:     tbench_tbench
 * Method:    tBenchSendResp
 * Signature: ([BI)V
 */
JNIEXPORT void JNICALL Java_tbench_tbench_tBenchSendResp
  (JNIEnv *, jclass, jbyteArray, jint, jint, jint, jint);

#ifdef __cplusplus
}
#endif
#endif
