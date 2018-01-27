Return-Path: <ebiggers3@gmail.com>
Return-Path: <ebiggers3@gmail.com>
From: Eric Biggers <ebiggers3@gmail.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] blktrace_api.h: fix comment for struct blk_user_trace_setup
Date: Fri, 26 Jan 2018 16:58:06 -0800
Message-Id: <20180127005806.105338-1-ebiggers3@gmail.com>
List-ID: <linux-block@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

'struct blk_user_trace_setup' is passed to BLKTRACESETUP, not
BLKTRACESTART.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/uapi/linux/blktrace_api.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 20d1490d6377..3c50e07ee833 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -131,7 +131,7 @@ enum {
 #define BLKTRACE_BDEV_SIZE	32
 
 /*
- * User setup structure passed with BLKTRACESTART
+ * User setup structure passed with BLKTRACESETUP
  */
 struct blk_user_trace_setup {
 	char name[BLKTRACE_BDEV_SIZE];	/* output */
-- 
2.16.0.rc1.238.g530d649a79-goog
